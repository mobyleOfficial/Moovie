import 'package:flutter/material.dart';

class MoovieFilterChipBar extends StatefulWidget {
  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const MoovieFilterChipBar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  State<MoovieFilterChipBar> createState() => _MoovieFilterChipBarState();
}

class _MoovieFilterChipBarState extends State<MoovieFilterChipBar> {
  final _rowKey = GlobalKey();
  final List<GlobalKey> _chipKeys = [];

  double _indicatorLeft = 0;
  double _indicatorWidth = 0;
  bool _hasMeasured = false;

  @override
  void initState() {
    super.initState();
    _syncKeys();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureIndicator());
  }

  @override
  void didUpdateWidget(MoovieFilterChipBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.labels.length != widget.labels.length) _syncKeys();
    if (oldWidget.selectedIndex != widget.selectedIndex ||
        oldWidget.labels.length != widget.labels.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _measureIndicator());
    }
  }

  void _syncKeys() {
    _chipKeys
      ..clear()
      ..addAll(List.generate(widget.labels.length, (_) => GlobalKey()));
  }

  void _measureIndicator() {
    if (!mounted) return;
    final rowBox =
        _rowKey.currentContext?.findRenderObject() as RenderBox?;
    if (rowBox == null) return;

    final index = widget.selectedIndex;
    if (index < 0 || index >= _chipKeys.length) return;

    final chipBox =
        _chipKeys[index].currentContext?.findRenderObject() as RenderBox?;
    if (chipBox == null) return;

    final chipOffset = chipBox.localToGlobal(Offset.zero, ancestor: rowBox);
    setState(() {
      _indicatorLeft = chipOffset.dx;
      _indicatorWidth = chipBox.size.width;
      _hasMeasured = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                key: _rowKey,
                children: [
                  for (var index = 0; index < widget.labels.length; index++)
                    Padding(
                      key: _chipKeys[index],
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                      label: Text(widget.labels[index]),
                      selected: widget.selectedIndex == index,
                      onSelected: (_) => widget.onSelected(index),
                      backgroundColor: Colors.transparent,
                      selectedColor: Colors.transparent,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                      elevation: 0,
                      pressElevation: 0,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: TextStyle(
                        color: widget.selectedIndex == index
                            ? colorScheme.onSecondaryContainer
                            : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                      showCheckmark: false,
                    ),
                    ),
                ],
              ),
            ),
            if (_hasMeasured)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                left: _indicatorLeft,
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  height: 2,
                  width: _indicatorWidth,
                  decoration: BoxDecoration(
                    color: colorScheme.onSecondaryContainer,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
