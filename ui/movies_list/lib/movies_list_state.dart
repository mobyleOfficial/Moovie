import 'package:movies/movies.dart';

sealed class MoviesListState {
  const MoviesListState();
}

class MoviesListLoading extends MoviesListState {
  const MoviesListLoading();
}

class MoviesListSuccess extends MoviesListState {
  final TrendingMovieListing listing;

  const MoviesListSuccess(this.listing);
}

class MoviesListError extends MoviesListState {
  final String message;

  const MoviesListError(this.message);
}