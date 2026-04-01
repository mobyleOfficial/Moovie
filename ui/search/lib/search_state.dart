sealed class SearchState {
  const SearchState();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchSuccess extends SearchState {
  const SearchSuccess();
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}