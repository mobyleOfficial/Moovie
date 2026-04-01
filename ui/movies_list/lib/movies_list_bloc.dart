import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

import 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  final GetTrendingMovies _getTrendingMovies;

  MoviesListCubit(this._getTrendingMovies) : super(const MoviesListLoading()) {
    loadTrendingMovies();
  }

  Future<void> loadTrendingMovies({int page = 1}) async {
    emit(const MoviesListLoading());

    final result = await _getTrendingMovies(page);

    switch (result) {
      case Success(:final data):
        emit(MoviesListSuccess(data));
      case Failure(:final error):
        emit(MoviesListError(error.message));
    }
  }
}