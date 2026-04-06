import 'package:movies/movies.dart';

sealed class MovieDetailState {
  const MovieDetailState();
}

class MovieDetailLoading extends MovieDetailState {
  const MovieDetailLoading();
}

class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail detail;

  const MovieDetailSuccess(this.detail);
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);
}
