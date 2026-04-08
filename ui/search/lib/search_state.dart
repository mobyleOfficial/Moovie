import 'package:movies/movies.dart';

sealed class SearchState {
  const SearchState();
}

class SearchIdle extends SearchState {
  const SearchIdle();
}

class SearchSearching extends SearchState {
  const SearchSearching();
}

class SearchResults extends SearchState {
  final List<Movie> movies;

  const SearchResults(this.movies);
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}
