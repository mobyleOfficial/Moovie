sealed class UserMovieListsState {
  const UserMovieListsState();
}

class UserMovieListsLoading extends UserMovieListsState {
  const UserMovieListsLoading();
}

class UserMovieListsSuccess extends UserMovieListsState {
  const UserMovieListsSuccess();
}

class UserMovieListsError extends UserMovieListsState {
  final String message;

  const UserMovieListsError(this.message);
}
