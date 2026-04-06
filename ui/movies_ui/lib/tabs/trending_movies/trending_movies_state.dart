sealed class TrendingMoviesState {
  const TrendingMoviesState();
}

class TrendingMoviesLoading extends TrendingMoviesState {
  const TrendingMoviesLoading();
}

class TrendingMoviesSuccess extends TrendingMoviesState {
  const TrendingMoviesSuccess();
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;

  const TrendingMoviesError(this.message);
}
