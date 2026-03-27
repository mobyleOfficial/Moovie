abstract class MoviesListState {
  const MoviesListState();
}

class MoviesListInitial extends MoviesListState {
  const MoviesListInitial();
}

class MoviesListLoading extends MoviesListState {
  const MoviesListLoading();
}

class MoviesListLoaded extends MoviesListState {
  const MoviesListLoaded();
}

class MoviesListError extends MoviesListState {
  final String message;

  const MoviesListError(this.message);
}