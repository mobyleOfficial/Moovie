import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_bloc.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_state.dart';

class TrendingMoviesScreen extends StatelessWidget {
  final void Function(int movieId, String movieTitle) onMovieTap;

  static const String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';

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
                    ? '$_posterBaseUrl${movie.posterPath}'
                    : null,
                onTap: () => onMovieTap(movie.id, movie.title),
              ),
              firstPageProgressIndicatorBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              firstPageErrorIndicatorBuilder: (_) =>
                  BlocBuilder<TrendingMoviesCubit, TrendingMoviesState>(
                    builder: (context, state) => Center(
                      child: Text(
                        state is TrendingMoviesError
                            ? state.message
                            : AppLocalizations.of(context)!.unknownError,
                      ),
                    ),
                  ),
            ),
          ),
    );
  }
}