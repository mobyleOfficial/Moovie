import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_bloc.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_screen.dart';
import 'package:movies_ui/tabs/lists/movies_lists_bloc.dart';
import 'package:movies_ui/tabs/lists/movies_lists_screen.dart';
import 'package:movies_ui/tabs/articles/movies_articles_screen.dart';
import 'package:reviews/reviews_list/reviews_screen.dart';

class MoviesHomeScreen extends StatefulWidget {
  final TrendingMoviesCubit cubit;
  final MoviesListsCubit listsCubit;
  final void Function(int movieId, String movieTitle) onMovieTap;
  final GetMovieReviews getMovieReviews;

  const MoviesHomeScreen({
    super.key,
    required this.cubit,
    required this.listsCubit,
    required this.onMovieTap,
    required this.getMovieReviews,
  });

  @override
  State<MoviesHomeScreen> createState() => _MoviesHomeScreenState();
}

class _MoviesHomeScreenState extends State<MoviesHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider.value(
      value: widget.cubit,
      child: Column(
        children: [
          MoovieFilterChipBar(
            labels: [
              l10n?.moviesTab ?? '',
              l10n?.reviewsTab ?? '',
              l10n?.moviesListListsTab ?? '',
              l10n?.moviesListArticlesTab ?? '',
            ],
            selectedIndex: _selectedIndex,
            onSelected: (index) => setState(() => _selectedIndex = index),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                TrendingMoviesScreen(onMovieTap: widget.onMovieTap),
                ReviewsScreen(getMovieReviews: widget.getMovieReviews),
                MoviesListsScreen(cubit: widget.listsCubit),
                const MoviesArticlesScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
