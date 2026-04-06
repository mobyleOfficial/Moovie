import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_bloc.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_screen.dart';
import 'package:movies_ui/tabs/lists/movies_lists_screen.dart';
import 'package:movies_ui/tabs/articles/movies_articles_screen.dart';
import 'package:reviews/reviews_list/reviews_screen.dart';

class MoviesHomeScreen extends StatelessWidget {
  final TrendingMoviesCubit cubit;
  final void Function(int movieId) onMovieTap;
  final GetMovieReviews getMovieReviews;
  final GetMovieCollections getMovieCollections;

  const MoviesHomeScreen({
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
                  MoovieKeepAliveTab(
                      child: TrendingMoviesScreen(onMovieTap: onMovieTap)),
                  MoovieKeepAliveTab(
                      child:
                          ReviewsScreen(getMovieReviews: getMovieReviews)),
                  MoovieKeepAliveTab(
                      child: MoviesListsScreen(
                          getMovieCollections: getMovieCollections)),
                  const MoovieKeepAliveTab(
                      child: MoviesArticlesScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}