import 'dart:async';

import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:user_activities_domain/domain.dart';
import 'new_user_activity_state.dart';

class NewUserActivityCubit extends Cubit<NewUserActivityState> {
  final SearchMovies _searchMovies;
  final ObserveMovieReviewDraftsList _observeMovieReviewDraftsList;
  final DeleteDraft _deleteDraft;
  final AddRecentSearch _addRecentSearch;
  final ObserveRecentSearches _observeRecentSearches;

  final StreamController<String> _queryController = StreamController<String>();
  late final StreamSubscription<String> _querySubscription;
  late final StreamSubscription<List<MovieReviewDraft>> _draftsSubscription;
  late final StreamSubscription<List<RecentSearch>> _recentSearchesSubscription;

  List<MovieReviewDraft> _currentDrafts = [];
  List<RecentSearch> _currentRecentSearches = [];
  bool _isSearching = false;

  static const _debounceDuration = Duration(milliseconds: 300);
  static const _minQueryLength = 3;

  NewUserActivityCubit(
    this._searchMovies,
    this._observeMovieReviewDraftsList,
    this._deleteDraft,
    this._addRecentSearch,
    this._observeRecentSearches,
  ) : super(const NewUserActivityLoading()) {
    _querySubscription = _queryController.stream
        .distinct()
        .debounce(_debounceDuration)
        .listen(_onQueryChanged);
    _draftsSubscription = _observeMovieReviewDraftsList().listen(
      _onDraftsChanged,
    );
    _recentSearchesSubscription = _observeRecentSearches().listen(
      _onRecentSearchesChanged,
    );
  }

  void _onDraftsChanged(List<MovieReviewDraft> drafts) {
    _currentDrafts = drafts;
    if (!_isSearching) {
      _emitSuccess();
    }
  }

  void _onRecentSearchesChanged(List<RecentSearch> searches) {
    _currentRecentSearches = searches;
    if (!_isSearching) {
      _emitSuccess();
    }
  }

  void _emitSuccess() => emit(NewUserActivitySuccess(
        drafts: _currentDrafts,
        recentSearches: _currentRecentSearches,
      ));

  void onSearchChanged(String query) {
    if (query.length < _minQueryLength) {
      _isSearching = false;
      _emitSuccess();
    }

    _queryController.add(query);
  }

  void _onQueryChanged(String query) {
    if (query.length < _minQueryLength) {
      return;
    }

    _isSearching = true;
    emit(const NewUserActivitySearching());
    _search(query);
  }

  Future<void> onSearchSubmitted(String query) async {
    if (query.length < _minQueryLength) return;
    await _addRecentSearch(query);
  }

  Future<void> _search(String query) async {
    final result = await _searchMovies(SearchMoviesParams(query: query));

    if (isClosed) return;

    switch (result) {
      case Success(:final data):
        emit(NewUserActivitySearchResults(data.movies));
      case Failure(:final error):
        emit(NewUserActivityError(error.message));
    }
  }

  Future<void> deleteDraft(int movieId) async => _deleteDraft(movieId);

  @override
  Future<void> close() {
    _querySubscription.cancel();
    _queryController.close();
    _draftsSubscription.cancel();
    _recentSearchesSubscription.cancel();
    return super.close();
  }
}
