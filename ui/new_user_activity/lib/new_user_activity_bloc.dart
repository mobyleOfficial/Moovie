import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:new_user_activity/new_user_activity_state.dart';

class NewUserActivityCubit extends Cubit<NewUserActivityState> {
  final SearchMovies _searchMovies;

  Timer? _debounceTimer;
  static const _debounceDuration = Duration(milliseconds: 300);
  static const _minQueryLength = 3;

  NewUserActivityCubit(this._searchMovies)
      : super(const NewUserActivityLoading()) {
    _load();
  }

  void _load() => emit(const NewUserActivitySuccess());

  void onSearchChanged(String query) {
    _debounceTimer?.cancel();

    if (query.length < _minQueryLength) {
      emit(const NewUserActivitySuccess());
      return;
    }

    emit(const NewUserActivitySearching());

    _debounceTimer = Timer(_debounceDuration, () => _search(query));
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

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
