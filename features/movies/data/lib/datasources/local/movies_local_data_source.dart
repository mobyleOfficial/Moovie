import 'package:movies_data/models/local/local_movie_review_draft.dart';
import 'package:movies_data/models/local/local_recent_search.dart';

abstract interface class MoviesLocalDataSource {
  void upsertMovieReviewDraft(LocalMovieReviewDraft draft);
  Stream<List<LocalMovieReviewDraft>> watchDrafts();
  void deleteDraftByMovieId(int movieId);
  void addRecentSearch(String query);
  Stream<List<LocalRecentSearch>> watchRecentSearches();
}
