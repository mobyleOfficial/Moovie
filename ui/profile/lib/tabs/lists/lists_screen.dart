import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

class ListsScreen extends StatefulWidget {
  final GetMovieCollections getMovieCollections;

  const ListsScreen({super.key, required this.getMovieCollections});

  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  int _totalPages = 1;

  late final PagingController<int, MovieCollection> _pagingController =
      PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;

      if (nextKey > _totalPages) {
        return null;
      }
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  Future<List<MovieCollection>> _fetchPage(int page) async {
    final result = await widget.getMovieCollections(page);

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.collections;
      case Failure(:final error):
        throw Exception(error.message);
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final coverColors = [
      colorScheme.primaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.surfaceContainerHighest,
    ];

    return PagingListener(
      controller: _pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedListView<int, MovieCollection>(
        state: pagingState,
        fetchNextPage: fetchNextPage,
        padding: const EdgeInsets.all(16),
        builderDelegate: PagedChildBuilderDelegate<MovieCollection>(
          itemBuilder: (context, collection, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ListTile(
              title: collection.title,
              movieCount: collection.movieCount,
              coverColor: coverColors[index % coverColors.length],
              moviesLabel: l10n?.profileMoviesWatched.toLowerCase() ?? '',
            ),
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          firstPageErrorIndicatorBuilder: (_) => Center(
            child: Text(l10n?.unknownError ?? ''),
          ),
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final int movieCount;
  final Color coverColor;
  final String moviesLabel;

  const _ListTile({
    required this.title,
    required this.movieCount,
    required this.coverColor,
    required this.moviesLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '$title, $movieCount $moviesLabel',
      button: true,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: ExcludeSemantics(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              children: [
                ExcludeSemantics(
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: coverColor,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$movieCount $moviesLabel',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  semanticLabel: '',
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
