import 'package:core/core.dart';
import 'package:movies_data/models/local/local_movie_review_draft.dart';
import 'package:movies_data/objectbox.g.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:user_activities_data/datasources/local/user_activities_local_data_source.dart';

class UserActivitiesLocalDataSourceImpl implements UserActivitiesLocalDataSource {
  final Box<LocalMovieReviewDraft> _box;
  final LocalClient _localClient;

  UserActivitiesLocalDataSourceImpl(this._box, this._localClient);

  @override
  Result<void> upsertMovieReviewDraft(LocalMovieReviewDraft draft) =>
      _localClient.execute(() {
        final existing = _box
            .query(LocalMovieReviewDraft_.movieId.equals(draft.movieId))
            .build()
            .findFirst();

        if (existing != null) {
          draft.id = existing.id;
        }

        _box.put(draft);
      });

  @override
  Stream<List<LocalMovieReviewDraft>> observeDraftsList() =>
      _localClient.watch(() => _box
          .query(LocalMovieReviewDraft_.statusIndex.equals(0))
          .order(LocalMovieReviewDraft_.updatedAt, flags: Order.descending)
          .watch(triggerImmediately: true)
          .map((query) => query.find()));

  @override
  Result<void> deleteDraftByMovieId(int movieId) =>
      _localClient.execute(() {
        final existing = _box
            .query(LocalMovieReviewDraft_.movieId.equals(movieId))
            .build()
            .findFirst();

        if (existing != null) {
          _box.remove(existing.id);
        }
      });

  @override
  Result<void> updateDraftStatus({
    required int movieId,
    required MovieReviewStatus status,
  }) =>
      _localClient.execute(() {
        final existing = _box
            .query(LocalMovieReviewDraft_.movieId.equals(movieId))
            .build()
            .findFirst();

        if (existing != null) {
          existing.statusIndex = status.index;
          _box.put(existing);
        }
      });

  @override
  Stream<List<LocalMovieReviewDraft>> observeSubmittingDrafts() =>
      _localClient.watch(() => _box
          .query(LocalMovieReviewDraft_.statusIndex
              .equals(MovieReviewStatus.submitting.index)
              .or(LocalMovieReviewDraft_.statusIndex
                  .equals(MovieReviewStatus.error.index)))
          .order(LocalMovieReviewDraft_.updatedAt, flags: Order.descending)
          .watch(triggerImmediately: true)
          .map((query) => query.find()));
}
