import 'package:core/core.dart';
import 'package:movies_data/models/local/local_movie_review_draft.dart';

abstract interface class UserActivitiesLocalDataSource {
  Result<void> upsertMovieReviewDraft(LocalMovieReviewDraft draft);
  Stream<List<LocalMovieReviewDraft>> observeDraftsList();
  Result<void> deleteDraftByMovieId(int movieId);
}
