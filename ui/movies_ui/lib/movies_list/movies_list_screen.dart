import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movies_list/movies_list_bloc.dart';
import 'package:movies_ui/movies_list/movies_list_state.dart';
import 'package:movies_ui/tabs/lists/movies_lists_screen.dart';
import 'package:movies_ui/tabs/articles/movies_articles_screen.dart';
import 'package:reviews/reviews_list/reviews_screen.dart';

class MoviesListScreen extends StatelessWidget {
  final MoviesListCubit cubit;
  final void Function(int movieId) onMovieTap;
  final GetMovieReviews getMovieReviews;
  final GetMovieCollections getMovieCollections;

  const MoviesListScreen({
    super.key,
    required this.cubit,
    required this.onMovieTap,
    required this.getMovieReviews,
    required this.getMovieCollections,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: cubit,
      child: BlocListener<MoviesListCubit, MoviesListState>(
        listener: (context, state) {},
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              MoovieTabBar(tabs: [
                l10n.moviesTab,
                l10n.reviewsTab,
                l10n.moviesListListsTab,
                l10n.moviesListArticlesTab,
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    _MoviesGrid(onMovieTap: onMovieTap),
                    ReviewsScreen(getMovieReviews: getMovieReviews),
                    MoviesListsScreen(
                        getMovieCollections: getMovieCollections),
                    const MoviesArticlesScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoviesGrid extends StatelessWidget {
  final void Function(int movieId) onMovieTap;

  const _MoviesGrid({required this.onMovieTap});

  static const String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';
  static const int _gridCrossAxisCount = 3;
  static const double _gridChildAspectRatio = 2 / 3;
  static const double _gridSpacing = 8;
  static const double _gridPadding = 16;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MoviesListCubit>();

    return PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedGridView<int, Movie>(
            state: pagingState,
            fetchNextPage: fetchNextPage,
            padding: const EdgeInsets.symmetric(
              horizontal: _gridPadding,
              vertical: _gridPadding,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridCrossAxisCount,
              childAspectRatio: _gridChildAspectRatio,
              crossAxisSpacing: _gridSpacing,
              mainAxisSpacing: _gridSpacing,
            ),
            builderDelegate: PagedChildBuilderDelegate<Movie>(
              itemBuilder: (context, movie, index) => _MoviePosterCard(
                movie: movie,
                onTap: () => onMovieTap(movie.id),
              ),
              firstPageProgressIndicatorBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              firstPageErrorIndicatorBuilder: (_) =>
                  BlocBuilder<MoviesListCubit, MoviesListState>(
                    builder: (context, state) => Center(
                      child: Text(
                        state is MoviesListError
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

class _MoviePosterCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  static const double _cardBorderRadius = 10;

  const _MoviePosterCard({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(_cardBorderRadius),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: InkWell(
          onTap: onTap,
          child: movie.posterPath.isNotEmpty
              ? Ink.image(
                  image: CachedNetworkImageProvider(
                    '${_MoviesGrid._posterBaseUrl}${movie.posterPath}',
                  ),
                  fit: BoxFit.cover,
                )
              : const Center(
                  child: Icon(Icons.movie, size: 36),
                ),
        ),
      ),
    );
}
