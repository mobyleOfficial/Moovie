import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

import 'package:search/release_date/movies/release_date_movies_bloc.dart';
import 'package:search/release_date/movies/release_date_movies_state.dart';

class ReleaseDateMoviesScreen extends StatelessWidget {
  final ReleaseDateMoviesCubit cubit;
  final void Function(int movieId, String movieTitle) onMovieTap;

  static const String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';

  const ReleaseDateMoviesScreen({
    super.key,
    required this.cubit,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ReleaseDateMoviesCubit, ReleaseDateMoviesState>(
        builder: (context, state) => switch (state) {
          ReleaseDateMoviesLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          ReleaseDateMoviesError(:final message) => Center(
              child: Text(message),
            ),
          ReleaseDateMoviesSuccess() => PagingListener(
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
                  itemBuilder: (context, movie, index) =>
                      MoovieMoviePosterCard(
                    imageUrl: movie.posterPath.isNotEmpty
                        ? '$_posterBaseUrl${movie.posterPath}'
                        : null,
                    onTap: () => onMovieTap(movie.id, movie.title),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  firstPageErrorIndicatorBuilder: (_) => Center(
                    child: Text(
                      AppLocalizations.of(context)?.unknownError ?? '',
                    ),
                  ),
                ),
              ),
            ),
        },
      ),
      ),
    );
  }
}
