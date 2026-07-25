import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_router.dart';
import 'package:movies_ui/tabs/lists/movies_list_tile.dart';

import 'package:search/featured_lists/featured_lists_bloc.dart';

class FeaturedListsScreen extends StatelessWidget {
  final FeaturedListsCubit cubit;

  const FeaturedListsScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedListView<int, MovieList>(
        state: pagingState,
        fetchNextPage: fetchNextPage,
        padding: const EdgeInsets.all(16),
        builderDelegate: PagedChildBuilderDelegate<MovieList>(
          itemBuilder: (context, movieList, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: MoviesListTile(
              title: movieList.name,
              creator: movieList.creator,
              description: movieList.description,
              posterPaths: movieList.info?.posterPaths ?? const [],
              onTap: () => context.router.push(
                MovieListDetailRoute(
                  listId: movieList.id,
                  listName: movieList.name,
                  posterPaths: movieList.info?.posterPaths ?? const [],
                ),
              ),
            ),
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          firstPageErrorIndicatorBuilder: (_) => MuuvieEmptyState(
            title: l10n?.emptyStateErrorTitle ?? '',
            message: l10n?.emptyStateErrorMessage ?? '',
            action: fetchNextPage,
            actionLabel: l10n?.emptyStateRetry ?? '',
          ),
          noItemsFoundIndicatorBuilder: (_) => MuuvieEmptyState(
            title: l10n?.emptyStateNoItemsTitle ?? '',
            message: l10n?.emptyStateNoItemsMessage ?? '',
          ),
        ),
      ),
      ),
    );
  }
}
