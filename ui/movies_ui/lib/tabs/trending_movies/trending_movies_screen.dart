import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_bloc.dart';

class TrendingMoviesScreen extends StatelessWidget {
  final void Function(int movieId, String movieTitle) onMovieTap;


  const TrendingMoviesScreen({
    super.key,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TrendingMoviesCubit>();

    return PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedGridView<int, Movie>(
            state: pagingState,
            fetchNextPage: fetchNextPage,
            padding: const EdgeInsets.symmetric(
              horizontal: moovieGridPadding,
              vertical: moovieGridPadding,
            ),
            gridDelegate: moovieGridDelegate,
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              itemBuilder: (context, movie, index) => MoovieMoviePosterCard(
                imageUrl: movie.posterPath.isNotEmpty
                    ? '${TmdbImageUrl.posterLarge}${movie.posterPath}'
                    : null,
                onTap: () => onMovieTap(movie.id, movie.title),
              ),
              firstPageProgressIndicatorBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              firstPageErrorIndicatorBuilder: (_) => MoovieEmptyState(
                title: AppLocalizations.of(context)?.emptyStateErrorTitle ?? '',
                message: AppLocalizations.of(context)?.emptyStateErrorMessage ?? '',
                action: fetchNextPage,
                actionLabel: AppLocalizations.of(context)?.emptyStateRetry ?? '',
              ),
              noItemsFoundIndicatorBuilder: (_) => MoovieEmptyState(
                title: AppLocalizations.of(context)?.emptyStateNoItemsTitle ?? '',
                message: AppLocalizations.of(context)?.emptyStateNoItemsMessage ?? '',
              ),
            ),
          ),
    );
  }
}