import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_detail/movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final int _movieId;

  MovieDetailCubit(this._getMovieDetail, this._movieId)
      : super(const MovieDetailLoading()) {
    _fetchMovieDetail();
  }

  Future<void> _fetchMovieDetail() async {
    final result = await _getMovieDetail(_movieId);

    switch (result) {
      case Success(:final data):
        emit(MovieDetailSuccess(data));
      case Failure(:final error):
        emit(MovieDetailError(error.message));
    }
  }
}
