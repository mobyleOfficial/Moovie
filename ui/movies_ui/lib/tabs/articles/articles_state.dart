sealed class ArticlesState {
  const ArticlesState();
}

class ArticlesLoading extends ArticlesState {
  const ArticlesLoading();
}

class ArticlesSuccess extends ArticlesState {
  const ArticlesSuccess();
}

class ArticlesError extends ArticlesState {
  final String message;

  const ArticlesError(this.message);
}
