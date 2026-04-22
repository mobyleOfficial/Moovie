import 'package:movies/movies.dart';

sealed class NewUserActivityState {
  const NewUserActivityState();
}

class NewUserActivityLoading extends NewUserActivityState {
  const NewUserActivityLoading();
}

class NewUserActivitySuccess extends NewUserActivityState {
  final List<MovieReviewDraft> drafts;
  final List<RecentSearch> recentSearches;

  const NewUserActivitySuccess({
    this.drafts = const [],
    this.recentSearches = const [],
  });
}

class NewUserActivitySearching extends NewUserActivityState {
  const NewUserActivitySearching();
}

class NewUserActivitySearchResults extends NewUserActivityState {
  final List<Movie> movies;

  const NewUserActivitySearchResults(this.movies);
}

class NewUserActivityError extends NewUserActivityState {
  final String message;

  const NewUserActivityError(this.message);
}
