import 'package:movies/movies.dart';

sealed class MoviesListState {
  const MoviesListState();
}

class MoviesListLoading extends MoviesListState {
  const MoviesListLoading();
}

class MoviesListSuccess extends MoviesListState {
  final List<Movie> movies;

  const MoviesListSuccess(this.movies);
}

class MoviesListError extends MoviesListState {
  final String message;

  const MoviesListError(this.message);
}
