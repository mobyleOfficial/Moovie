import 'package:movies_data/datasources/local/movies_local_data_source.dart';
import 'package:movies_data/models/local/local_movie_review_draft.dart';
import 'package:movies_data/models/local/local_recent_search.dart';
import 'package:movies_data/objectbox.g.dart';

class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final Box<LocalMovieReviewDraft> _box;
  final Box<LocalRecentSearch> _recentSearchBox;

  static const _maxRecentSearches = 100;

  MoviesLocalDataSourceImpl(this._box, this._recentSearchBox);

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

  @override
  void addRecentSearch(String query) {
    final existing = _recentSearchBox
        .query(LocalRecentSearch_.query.equals(query))
        .build()
        .findFirst();

    final search = LocalRecentSearch(
      id: existing?.id ?? 0,
      query: query,
      searchedAt: DateTime.now(),
    );

    _recentSearchBox.put(search);

    final count = _recentSearchBox.count();
    if (count > _maxRecentSearches) {
      final oldest = _recentSearchBox
          .query()
          .order(LocalRecentSearch_.searchedAt)
          .build()
          .findFirst();
      if (oldest != null) {
        _recentSearchBox.remove(oldest.id);
      }
    }
  }

  @override
  Stream<List<LocalRecentSearch>> watchRecentSearches() => _recentSearchBox
      .query()
      .order(LocalRecentSearch_.searchedAt, flags: Order.descending)
      .watch(triggerImmediately: true)
      .map((query) => query.find());
}
