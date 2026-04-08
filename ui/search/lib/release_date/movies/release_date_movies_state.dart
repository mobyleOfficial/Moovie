sealed class ReleaseDateMoviesState {
  const ReleaseDateMoviesState();
}

class ReleaseDateMoviesLoading extends ReleaseDateMoviesState {
  const ReleaseDateMoviesLoading();
}

class ReleaseDateMoviesSuccess extends ReleaseDateMoviesState {
  const ReleaseDateMoviesSuccess();
}

class ReleaseDateMoviesError extends ReleaseDateMoviesState {
  final String message;

  const ReleaseDateMoviesError(this.message);
}
