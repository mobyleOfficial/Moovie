import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:search/search_bloc.dart';
import 'package:search/search_router.dart';
import 'package:search/search_state.dart';

class SearchScreen extends StatefulWidget {
  final SearchCubit cubit;

  const SearchScreen({super.key, required this.cubit});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
    _searchController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _searchController.removeListener(_onTextChanged);
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    _updateSearchVisibility();
  }

  void _onTextChanged() {
    _updateSearchVisibility();
  }

  void _updateSearchVisibility() {
    final shouldShow =
        _focusNode.hasFocus && _searchController.text.isNotEmpty;
    if (shouldShow != _showSearchResults) {
      setState(() => _showSearchResults = shouldShow);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider.value(
      value: widget.cubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: MoovieEditText(
              controller: _searchController,
              focusNode: _focusNode,
              placeholder: l10n?.searchHint ?? '',
              textInputAction: TextInputAction.search,
              onChanged: widget.cubit.onSearchChanged,
            ),
          ),
          Expanded(
            child: _showSearchResults
                ? _SearchResultsSection(cubit: widget.cubit)
                : _BrowseSection(l10n: l10n, colorScheme: colorScheme, textTheme: textTheme),
          ),
        ],
      ),
    );
  }
}

class _SearchResultsSection extends StatefulWidget {
  final SearchCubit cubit;

  const _SearchResultsSection({required this.cubit});

  @override
  State<_SearchResultsSection> createState() => _SearchResultsSectionState();
}

class _SearchResultsSectionState extends State<_SearchResultsSection> {
  static const _categories = [
    'Movies',
    'Reviews',
    'Lists',
    'Cast & Crew',
    'Stories',
    'Users',
    'Articles',
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              for (var index = 0; index < _categories.length; index++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(_categories[index]),
                    selected: _selectedIndex == index,
                    onSelected: (_) => setState(() => _selectedIndex = index),
                    selectedColor: colorScheme.secondaryContainer,
                    checkmarkColor: colorScheme.onSecondaryContainer,
                    labelStyle: TextStyle(
                      color: _selectedIndex == index
                          ? colorScheme.onSecondaryContainer
                          : colorScheme.onSurfaceVariant,
                      fontWeight: _selectedIndex == index
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    showCheckmark: false,
                  ),
                ),
            ],
          ),
        ),
        Divider(height: 1, color: colorScheme.outlineVariant),
        Expanded(
          child: _selectedIndex == 0
              ? _MoviesResultsTab(cubit: widget.cubit)
              : Center(
                  child: Text(
                    '${_categories[_selectedIndex]} coming soon',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
        ),
      ],
    );
  }
}

class _MoviesResultsTab extends StatelessWidget {
  final SearchCubit cubit;

  const _MoviesResultsTab({required this.cubit});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) => switch (state) {
        SearchSearching() => const Center(
            child: CircularProgressIndicator(),
          ),
        SearchResults(:final movies) => movies.isEmpty
            ? Center(
                child: Text(
                  AppLocalizations.of(context)?.noResults ?? '',
                  style: textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: movies.length,
                separatorBuilder: (_, __) => Divider(
                  indent: 72,
                  height: 1,
                  color: colorScheme.outlineVariant,
                ),
                itemBuilder: (context, index) => _MovieResultTile(
                  movie: movies[index],
                ),
              ),
        SearchError(:final message) => Center(child: Text(message)),
        SearchIdle() => const SizedBox.shrink(),
      },
    );
  }
}

class _MovieResultTile extends StatelessWidget {
  final Movie movie;

  const _MovieResultTile({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => context.router.push(
        MovieDetailRoute(movieId: movie.id, movieTitle: movie.title),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: SizedBox(
                width: 44,
                height: 64,
                child: movie.posterPath.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl:
                            '${TmdbImageUrl.posterSmall}${movie.posterPath}',
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: colorScheme.surfaceContainerHighest,
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.movie,
                            size: 20,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      )
                    : Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.movie,
                          size: 20,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (movie.releaseDate.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      movie.releaseDate.length >= 4
                          ? movie.releaseDate.substring(0, 4)
                          : movie.releaseDate,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (movie.voteAverage > 0) ...[
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    size: 14,
                    color: colorScheme.onTertiaryContainer,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BrowseSection extends StatelessWidget {
  final AppLocalizations? l10n;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  const _BrowseSection({
    required this.l10n,
    required this.colorScheme,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                onTap: () => context.router.push(
                  const ReleaseDateDecadesRoute(),
                ),
              ),
              _BrowseItem(
                icon: Icons.category_outlined,
                label: l10n?.searchBrowseGenreCountryLanguage ?? '',
                onTap: () => context.router.push(
                  const BrowseCategoriesRoute(),
                ),
              ),
              _BrowseItem(
                icon: Icons.play_circle_outline,
                label: l10n?.searchBrowseService ?? '',
              ),
              _BrowseItem(
                icon: Icons.trending_up,
                label: l10n?.searchBrowseMostPopular ?? '',
                onTap: () => context.router.push(
                  const MostPopularRoute(),
                ),
              ),
              _BrowseItem(
                icon: Icons.star_outline,
                label: l10n?.searchBrowseHighestRated ?? '',
                onTap: () => context.router.push(
                  const HighestRatedRoute(),
                ),
              ),
              _BrowseItem(
                icon: Icons.schedule,
                label: l10n?.searchBrowseMostAnticipated ?? '',
                onTap: () => context.router.push(
                  const MostAnticipatedRoute(),
                ),
              ),
              _BrowseItem(
                icon: Icons.list_alt,
                label: l10n?.searchBrowseFeaturedLists ?? '',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BrowseItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _BrowseItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: ExcludeSemantics(child: Icon(icon, color: colorScheme.onSurface)),
      title: Text(label),
      trailing: ExcludeSemantics(
        child: Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
      ),
      onTap: onTap ?? () {},
    );
  }
}
