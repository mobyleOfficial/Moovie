import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

import 'package:search/highest_rated/highest_rated_bloc.dart';
import 'package:search/highest_rated/highest_rated_state.dart';

class HighestRatedScreen extends StatelessWidget {
  final HighestRatedCubit cubit;
  final void Function(int movieId, String movieTitle) onMovieTap;

  static const String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';

  const HighestRatedScreen({
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
        child: BlocBuilder<HighestRatedCubit, HighestRatedState>(
          builder: (context, state) => switch (state) {
            HighestRatedLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            HighestRatedError(:final message) => Center(
                child: Text(message),
              ),
            HighestRatedSuccess() => PagingListener(
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
