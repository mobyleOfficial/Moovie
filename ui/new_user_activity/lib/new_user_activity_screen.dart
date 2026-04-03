import 'package:common/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_activity/model/tab_items.dart';
import 'package:new_user_activity/new_user_activity_bloc.dart';
import 'package:new_user_activity/new_user_activity_state.dart';

class NewUserActivityScreen extends StatefulWidget {
  final NewUserActivityCubit cubit;

  const NewUserActivityScreen({super.key, required this.cubit});

  @override
  State<NewUserActivityScreen> createState() => _NewUserActivityScreenState();
}

class _NewUserActivityScreenState extends State<NewUserActivityScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focusNode.requestFocus());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<ActivityItem> _buildItems(AppLocalizations l10n) => [
        SectionHeader(l10n.newUserActivityDraftsSection),
        const DraftItem(
          title: 'Review of Dune: Part Two',
          subtitle: 'Edited · 2 hours ago',
        ),
        const DraftItem(
          title: 'My Top Sci-Fi Films of 2024',
          subtitle: 'Edited · Yesterday',
        ),
        SectionHeader(l10n.newUserActivityRecentSection),
        const SearchItem(query: 'Christopher Nolan films', time: '5m ago'),
        const SearchItem(query: 'best horror movies 2024', time: '1h ago'),
        const SearchItem(query: 'Wes Anderson', time: 'Yesterday'),
        const SearchItem(query: 'A24 films ranked', time: '2 days ago'),
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = _buildItems(l10n);
    final colorScheme = Theme.of(context).colorScheme;
    final searchField = Theme(
      data: Theme.of(context).copyWith(
        colorScheme: colorScheme.copyWith(
          surfaceContainerHighest: Colors.white.withValues(alpha: 0.15),
          onSurface: Colors.white,
          onSurfaceVariant: Colors.white.withValues(alpha: 0.7),
          primary: Colors.white,
        ),
      ),
      child: MoovieEditText(
        controller: _searchController,
        focusNode: _focusNode,
        placeholder: l10n.searchHint,
        textInputAction: TextInputAction.search,
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: (isIOS
            ? CupertinoNavigationBar(
                backgroundColor: CupertinoColors.black,
                leading: const MoovieCloseButton(),
                middle: searchField,
              )
            : AppBar(
                backgroundColor: Colors.black,
                leading: const MoovieCloseButton(),
                title: searchField,
                titleSpacing: 0,
              )) as PreferredSizeWidget,
        body: BlocProvider.value(
          value: widget.cubit,
          child: BlocBuilder<NewUserActivityCubit, NewUserActivityState>(
            builder: (context, state) => switch (state) {
              NewUserActivityLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              NewUserActivityError() => Center(
                  child: Text(state.message),
                ),
              NewUserActivitySuccess() => ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => switch (items[index]) {
                    SectionHeader(:final label) => _SectionHeaderTile(label: label),
                    DraftItem(:final title, :final subtitle) => _DraftTile(
                        title: title,
                        subtitle: subtitle,
                      ),
                    SearchItem(:final query, :final time) => _SearchTile(
                        query: query,
                        time: time,
                      ),
                  },
                ),
            },
          ),
        ),
      ),
    );
  }
}

class _SectionHeaderTile extends StatelessWidget {
  final String label;

  const _SectionHeaderTile({required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(
        label,
        style: textTheme.labelMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _DraftTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const _DraftTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '$title, $subtitle',
      button: true,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 20,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              ExcludeSemantics(
                child: Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchTile extends StatelessWidget {
  final String query;
  final String time;

  const _SearchTile({required this.query, required this.time});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '$query, $time',
      button: true,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              ExcludeSemantics(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.history,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  query,
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              ExcludeSemantics(
                child: Text(
                  time,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
