import 'package:core/core.dart';
import 'package:movies_data/models/local/local_movie_review_draft.dart';
import 'package:movies_data/models/local/local_recent_search.dart';

abstract interface class MoviesLocalDataSource {
  Result<void> upsertMovieReviewDraft(LocalMovieReviewDraft draft);
  Stream<List<LocalMovieReviewDraft>> observeDraftsList();
  Result<void> deleteDraftByMovieId(int movieId);
  Result<void> addRecentSearch(String query);
  Stream<List<LocalRecentSearch>> watchRecentSearches();
}
