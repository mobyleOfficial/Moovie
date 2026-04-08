sealed class MoviesListsState {
  const MoviesListsState();
}

class MoviesListsLoading extends MoviesListsState {
  const MoviesListsLoading();
}

class MoviesListsSuccess extends MoviesListsState {
  const MoviesListsSuccess();
}

class MoviesListsError extends MoviesListsState {
  final String message;

  const MoviesListsError(this.message);
}