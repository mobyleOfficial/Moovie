import 'dart:async';

import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:new_user_activity/new_user_activity_state.dart';

class NewUserActivityCubit extends Cubit<NewUserActivityState> {
  final SearchMovies _searchMovies;
  final ObserveMovieReviewDraftsList _observeMovieReviewDraftsList;
  final DeleteDraft _deleteDraft;

  final StreamController<String> _queryController = StreamController<String>();
  late final StreamSubscription<String> _querySubscription;
  late final StreamSubscription<List<MovieReviewDraft>> _draftsSubscription;

  List<MovieReviewDraft> _currentDrafts = [];
  bool _isSearching = false;

  static const _debounceDuration = Duration(milliseconds: 300);
  static const _minQueryLength = 3;

  NewUserActivityCubit(
    this._searchMovies,
    this._observeMovieReviewDraftsList,
    this._deleteDraft,
  ) : super(const NewUserActivityLoading()) {
    _querySubscription = _queryController.stream
        .distinct()
        .debounce(_debounceDuration)
        .listen(_onQueryChanged);
    _draftsSubscription = _observeMovieReviewDraftsList().listen(
      _onDraftsChanged,
    );
  }

  void _onDraftsChanged(List<MovieReviewDraft> drafts) {
    _currentDrafts = drafts;
    if (!_isSearching) {
      emit(NewUserActivitySuccess(drafts: drafts));
    }
  }

  void onSearchChanged(String query) {
    if (query.length < _minQueryLength) {
      _isSearching = false;
      emit(NewUserActivitySuccess(drafts: _currentDrafts));
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
    return super.close();
  }
}
