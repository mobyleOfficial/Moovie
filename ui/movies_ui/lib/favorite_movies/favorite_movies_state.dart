sealed class FavoriteMoviesState {
  const FavoriteMoviesState();
}

class FavoriteMoviesLoading extends FavoriteMoviesState {
  const FavoriteMoviesLoading();
}

class FavoriteMoviesSuccess extends FavoriteMoviesState {
  const FavoriteMoviesSuccess();
}

class FavoriteMoviesError extends FavoriteMoviesState {
  final String message;

  const FavoriteMoviesError(this.message);
}
