import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_router.dart';
import 'package:movies_ui/tabs/lists/movies_list_tile.dart';
import 'package:movies_ui/tabs/lists/movies_lists_bloc.dart';

class MoviesListsScreen extends StatelessWidget {
  final MoviesListsCubit cubit;
  final bool showPopularHeader;

  const MoviesListsScreen({
    super.key,
    required this.cubit,
    this.showPopularHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedListView<int, MovieList>(
        state: pagingState,
        fetchNextPage: fetchNextPage,
        padding: const EdgeInsets.all(16),
        builderDelegate: PagedChildBuilderDelegate<MovieList>(
          itemBuilder: (context, movieList, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 && showPopularHeader) ...[
                Text(
                  l10n.moviesListPopularThisWeek,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MoviesListTile(
                  title: movieList.name,
                  creator: movieList.creator,
                  description: movieList.description,
                  posterPaths: movieList.posterPaths,
                  onTap: () => context.router.push(
                    MovieListDetailRoute(
                      listId: movieList.id,
                      listName: movieList.name,
                      posterPaths: movieList.posterPaths,
                    ),
                  ),
                ),
              ),
            ],
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          firstPageErrorIndicatorBuilder: (_) => Center(
            child: Text(l10n.unknownError),
          ),
        ),
      ),
    );
  }
}