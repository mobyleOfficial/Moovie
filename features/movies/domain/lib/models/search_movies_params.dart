class SearchMoviesParams {
  final String query;
  final int page;

  const SearchMoviesParams({
    required this.query,
    this.page = 1,
  });
}
