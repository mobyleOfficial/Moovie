import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search_bloc.dart';
import 'package:search/search_state.dart';

class SearchScreen extends StatefulWidget {
  final SearchCubit cubit;

  const SearchScreen({super.key, required this.cubit});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider.value(
      value: widget.cubit,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: MoovieEditText(
              controller: _searchController,
              placeholder: l10n?.searchHint ?? '',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              l10n?.searchBrowse ?? '',
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _BrowseItem(
                  icon: Icons.calendar_today_outlined,
                  label: l10n?.searchBrowseReleaseDate ?? '',
                ),
                _BrowseItem(
                  icon: Icons.category_outlined,
                  label: l10n?.searchBrowseGenre ?? '',
                ),
                _BrowseItem(
                  icon: Icons.language,
                  label: l10n?.searchBrowseCountryAndLanguage ?? '',
                ),
                _BrowseItem(
                  icon: Icons.play_circle_outline,
                  label: l10n?.searchBrowseService ?? '',
                ),
                _BrowseItem(
                  icon: Icons.trending_up,
                  label: l10n?.searchBrowseMostPopular ?? '',
                ),
                _BrowseItem(
                  icon: Icons.star_outline,
                  label: l10n?.searchBrowseHighestRated ?? '',
                ),
                _BrowseItem(
                  icon: Icons.schedule,
                  label: l10n?.searchBrowseMostAnticipated ?? '',
                ),
                _BrowseItem(
                  icon: Icons.list_alt,
                  label: l10n?.searchBrowseFeaturedLists ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowseItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BrowseItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: ExcludeSemantics(child: Icon(icon, color: colorScheme.onSurface)),
      title: Text(label),
      trailing: ExcludeSemantics(
        child: Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
      ),
      onTap: () {},
    );
  }
}
