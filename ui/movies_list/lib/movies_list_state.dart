sealed class MoviesListState {
  const MoviesListState();
}

class MoviesListLoading extends MoviesListState {
  const MoviesListLoading();
}

class MoviesListSuccess extends MoviesListState {
  const MoviesListSuccess();
}

class MoviesListError extends MoviesListState {
  final String message;

  const MoviesListError(this.message);
}