import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/home/movies_home_screen.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:movies_ui/tabs/lists/movies_lists_bloc.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_bloc.dart';

@RoutePage()
class MoviesHomePage extends StatefulWidget {
  const MoviesHomePage({super.key});

  @override
  State<MoviesHomePage> createState() => _MoviesHomePageState();
}

class _MoviesHomePageState extends State<MoviesHomePage> {
  late final TrendingMoviesCubit _trendingCubit =
      TrendingMoviesCubit(GetIt.I<GetTrendingMovies>());
  late final MoviesListsCubit _listsCubit =
      MoviesListsCubit(GetIt.I<GetMovieLists>());

  @override
  void dispose() {
    _trendingCubit.close();
    _listsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MoviesHomeScreen(
        cubit: _trendingCubit,
        listsCubit: _listsCubit,
        onMovieTap: (movieId, movieTitle) => context.router.push(
          MovieDetailRoute(movieId: movieId, movieTitle: movieTitle),
        ),
        getMovieReviews: GetIt.I<GetMovieReviews>(),
      );
}