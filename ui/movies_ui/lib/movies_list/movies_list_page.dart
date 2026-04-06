import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:movies_ui/movies_list/movies_list_bloc.dart';
import 'package:movies_ui/movies_list/movies_list_screen.dart';

@RoutePage()
class MoviesListPage extends StatefulWidget {
  final GetTrendingMovies getTrendingMovies;
  final GetMovieReviews getMovieReviews;
  final GetMovieCollections getMovieCollections;

  const MoviesListPage({
    super.key,
    required this.getTrendingMovies,
    required this.getMovieReviews,
    required this.getMovieCollections,
  });

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  late final MoviesListCubit _cubit = MoviesListCubit(widget.getTrendingMovies);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MoviesListScreen(
        cubit: _cubit,
        onMovieTap: (movieId) => context.router.root.push(
          MovieDetailRoute(movieId: movieId),
        ),
        getMovieReviews: widget.getMovieReviews,
        getMovieCollections: widget.getMovieCollections,
      );
}
