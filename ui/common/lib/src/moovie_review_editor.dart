import 'package:flutter/material.dart';

import 'moovie_bottom_sheet.dart';
import 'moovie_dialog.dart';
import '../app_localizations.dart';

class MoovieReviewEditor extends StatefulWidget {
  final String? initialHtml;

  const MoovieReviewEditor({super.key, this.initialHtml});

  static Future<String?> show(BuildContext context, {String? initialHtml}) =>
      MoovieBottomSheet.show<String>(
        context: context,
        builder: (_) => MoovieReviewEditor(initialHtml: initialHtml),
      );

  @override
  State<MoovieReviewEditor> createState() => _MoovieReviewEditorState();
}

class _MoovieReviewEditorState extends State<MoovieReviewEditor> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    final initialText = htmlToEditable(widget.initialHtml ?? '');
    _controller = TextEditingController(text: initialText);
    _focusNode = FocusNode();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _wrapSelection(String openTag, String closeTag) {
    final selection = _controller.selection;
    final text = _controller.text;

    if (!selection.isValid || selection.isCollapsed) {
      final offset = selection.baseOffset;
      final newText =
          '${text.substring(0, offset)}$openTag$closeTag${text.substring(offset)}';
      _controller.value = TextEditingValue(
        text: newText,
        selection:
            TextSelection.collapsed(offset: offset + openTag.length),
      );
      return;
    }

    final selectedText = text.substring(selection.start, selection.end);
    final newText =
        '${text.substring(0, selection.start)}$openTag$selectedText$closeTag${text.substring(selection.end)}';
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.start +
            openTag.length +
            selectedText.length +
            closeTag.length,
      ),
    );
  }

  void _insertBlock(String prefix) {
    final selection = _controller.selection;
    final text = _controller.text;
    final offset = selection.isValid ? selection.baseOffset : text.length;

    final needsNewline = offset > 0 && text[offset - 1] != '\n';
    final insert = '${needsNewline ? '\n' : ''}$prefix';
    final newText =
        '${text.substring(0, offset)}$insert${text.substring(offset)}';
    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: offset + insert.length),
    );
  }

  void _onClear() {
    final l10n = AppLocalizations.of(context)!;
    MoovieDialog.show(
      context: context,
      title: l10n.reviewEditorClearConfirmTitle,
      content: l10n.reviewEditorClearConfirmContent,
      confirmText: l10n.reviewEditorClear,
      cancelText: l10n.cancel,
      onConfirm: () {
        _controller.clear();
      },
    );
  }

  void _onDone() {
    final html = editableToHtml(_controller.text);
    Navigator.of(context).pop(html.trim().isEmpty ? null : html);
  }

  static String editableToHtml(String text) {
    if (text.trim().isEmpty) return '';

    var result = text;

    result = result.replaceAllMapped(
      RegExp(r'\*\*(.+?)\*\*'),
      (match) => '<b>${match.group(1)}</b>',
    );
    result = result.replaceAllMapped(
      RegExp(r'(?<!\*)\*([^*]+?)\*(?!\*)'),
      (match) => '<i>${match.group(1)}</i>',
    );
    result = result.replaceAllMapped(
      RegExp(r'~~(.+?)~~'),
      (match) => '<s>${match.group(1)}</s>',
    );
    result = result.replaceAllMapped(
      RegExp(r'\|\|(.+?)\|\|'),
      (match) => '<span class="spoiler">${match.group(1)}</span>',
    );

    final lines = result.split('\n');
    final buffer = StringBuffer();
    var inList = false;

    for (final line in lines) {
      final trimmed = line.trim();

      if (trimmed.startsWith('# ')) {
        if (inList) {
          buffer.write('</ul>');
          inList = false;
        }
        buffer.write('<h1>${trimmed.substring(2)}</h1>');
      } else if (trimmed.startsWith('## ')) {
        if (inList) {
          buffer.write('</ul>');
          inList = false;
        }
        buffer.write('<h2>${trimmed.substring(3)}</h2>');
      } else if (trimmed.startsWith('- ') || trimmed.startsWith('* ')) {
        if (!inList) {
          buffer.write('<ul>');
          inList = true;
        }
        buffer.write('<li>${trimmed.substring(2)}</li>');
      } else if (trimmed.isEmpty) {
        if (inList) {
          buffer.write('</ul>');
          inList = false;
        }
      } else {
        if (inList) {
          buffer.write('</ul>');
          inList = false;
        }
        buffer.write('<p>$trimmed</p>');
      }
    }

    if (inList) {
      buffer.write('</ul>');
    }

    return buffer.toString();
  }

  static String htmlToEditable(String html) {
    if (html.trim().isEmpty) return '';

    var result = html;

    result = result.replaceAllMapped(
      RegExp(r'<b>(.*?)</b>'),
      (match) => '**${match.group(1)}**',
    );
    result = result.replaceAllMapped(
      RegExp(r'<i>(.*?)</i>'),
      (match) => '*${match.group(1)}*',
    );
    result = result.replaceAllMapped(
      RegExp(r'<s>(.*?)</s>'),
      (match) => '~~${match.group(1)}~~',
    );
    result = result.replaceAllMapped(
      RegExp(r'<span class="spoiler">(.*?)</span>'),
      (match) => '||${match.group(1)}||',
    );
    result = result.replaceAllMapped(
      RegExp(r'<h1>(.*?)</h1>'),
      (match) => '# ${match.group(1)}\n',
    );
    result = result.replaceAllMapped(
      RegExp(r'<h2>(.*?)</h2>'),
      (match) => '## ${match.group(1)}\n',
    );
    result = result.replaceAll(RegExp(r'<ul>'), '');
    result = result.replaceAll(RegExp(r'</ul>'), '');
    result = result.replaceAllMapped(
      RegExp(r'<li>(.*?)</li>'),
      (match) => '- ${match.group(1)}\n',
    );
    result = result.replaceAllMapped(
      RegExp(r'<p>(.*?)</p>'),
      (match) => '${match.group(1)}\n\n',
    );

    return result.trimRight();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      color: colorScheme.surface,
      child: Column(
        children: [
          _EditorAppBar(
            onClear: _onClear,
            onDone: _onDone,
            title: l10n.reviewEditorTitle,
            clearLabel: l10n.reviewEditorClear,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  height: 1.6,
                ),
                decoration: InputDecoration(
                  hintText: l10n.reviewEditorPlaceholder,
                  hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          _FormattingToolbar(
            onBold: () => _wrapSelection('**', '**'),
            onItalic: () => _wrapSelection('*', '*'),
            onStrikethrough: () => _wrapSelection('~~', '~~'),
            onSpoiler: () => _wrapSelection('||', '||'),
            onHeading: () => _insertBlock('# '),
            onSubheading: () => _insertBlock('## '),
            onList: () => _insertBlock('- '),
            onParagraph: () => _insertBlock('\n'),
          ),
          SizedBox(height: bottomInset),
        ],
      ),
    );
  }
}

class _EditorAppBar extends StatelessWidget {
  final VoidCallback onClear;
  final VoidCallback onDone;
  final String title;
  final String clearLabel;

  const _EditorAppBar({
    required this.onClear,
    required this.onDone,
    required this.title,
    required this.clearLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: onClear,
            child: Text(
              clearLabel,
              style: TextStyle(color: colorScheme.error),
            ),
          ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          Semantics(
            label: 'Done',
            button: true,
            child: IconButton(
              onPressed: onDone,
              icon: Icon(Icons.check, color: colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormattingToolbar extends StatelessWidget {
  final VoidCallback onBold;
  final VoidCallback onItalic;
  final VoidCallback onStrikethrough;
  final VoidCallback onSpoiler;
  final VoidCallback onHeading;
  final VoidCallback onSubheading;
  final VoidCallback onList;
  final VoidCallback onParagraph;

  const _FormattingToolbar({
    required this.onBold,
    required this.onItalic,
    required this.onStrikethrough,
    required this.onSpoiler,
    required this.onHeading,
    required this.onSubheading,
    required this.onList,
    required this.onParagraph,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            _ToolbarButton(
              icon: Icons.format_bold,
              tooltip: 'Bold',
              onPressed: onBold,
            ),
            _ToolbarButton(
              icon: Icons.format_italic,
              tooltip: 'Italic',
              onPressed: onItalic,
            ),
            _ToolbarButton(
              icon: Icons.format_strikethrough,
              tooltip: 'Strikethrough',
              onPressed: onStrikethrough,
            ),
            _ToolbarButton(
              icon: Icons.visibility_off_outlined,
              tooltip: 'Spoiler',
              onPressed: onSpoiler,
            ),
            _ToolbarDivider(),
            _ToolbarButton(
              icon: Icons.title,
              tooltip: 'Heading',
              onPressed: onHeading,
            ),
            _ToolbarButton(
              icon: Icons.text_fields,
              tooltip: 'Subheading',
              onPressed: onSubheading,
            ),
            _ToolbarButton(
              icon: Icons.format_list_bulleted,
              tooltip: 'List',
              onPressed: onList,
            ),
            _ToolbarButton(
              icon: Icons.segment,
              tooltip: 'Paragraph',
              onPressed: onParagraph,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _ToolbarButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(icon, size: 20, color: colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}

class _ToolbarDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 1,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: colorScheme.outlineVariant,
    );
  }
}
