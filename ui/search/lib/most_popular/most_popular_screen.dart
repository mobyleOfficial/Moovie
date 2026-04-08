import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

import 'package:search/most_popular/most_popular_bloc.dart';
import 'package:search/most_popular/most_popular_state.dart';

class MostPopularScreen extends StatelessWidget {
  final MostPopularCubit cubit;
  final void Function(int movieId, String movieTitle) onMovieTap;


  const MostPopularScreen({
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
        child: BlocBuilder<MostPopularCubit, MostPopularState>(
          builder: (context, state) => switch (state) {
            MostPopularLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            MostPopularError(:final message) => Center(
                child: Text(message),
              ),
            MostPopularSuccess() => PagingListener(
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
                          ? '${TmdbImageUrl.posterLarge}${movie.posterPath}'
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
