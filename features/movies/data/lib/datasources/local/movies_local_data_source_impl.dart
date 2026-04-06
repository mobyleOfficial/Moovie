import 'package:movies_data/datasources/local/movies_local_data_source.dart';
import 'package:movies_data/models/local/local_movie_review_draft.dart';
import 'package:movies_data/objectbox.g.dart';

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final Box<LocalMovieReviewDraft> _box;

  MoviesLocalDataSourceImpl(this._box);

  @override
  void upsertMovieReviewDraft(LocalMovieReviewDraft draft) {
    final existing = _box
        .query(LocalMovieReviewDraft_.movieId.equals(draft.movieId))
        .build()
        .findFirst();

    if (existing != null) {
      draft.id = existing.id;
    }

    _box.put(draft);
  }

  @override
  Stream<List<LocalMovieReviewDraft>> watchDrafts() => _box
      .query(LocalMovieReviewDraft_.statusIndex
          .equals(0))
      .order(LocalMovieReviewDraft_.updatedAt, flags: Order.descending)
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  @override
  void deleteDraftByMovieId(int movieId) {
    final existing = _box
        .query(LocalMovieReviewDraft_.movieId.equals(movieId))
        .build()
        .findFirst();

    if (existing != null) {
      _box.remove(existing.id);
    }
  }
}
