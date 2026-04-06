import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/tabs/trending_movies/trending_movies_state.dart';

class TrendingMoviesCubit extends Cubit<TrendingMoviesState> {
  final GetTrendingMovies _getTrendingMovies;

  int _totalPages = 1;

  late final PagingController<int, Movie> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;

      if (nextKey > _totalPages) {
        return null;
      }
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  TrendingMoviesCubit(this._getTrendingMovies) : super(const TrendingMoviesLoading());

  Future<List<Movie>> _fetchPage(int page) async {
    final result = await _getTrendingMovies(page);

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.movies;
      case Failure(:final error):
        throw Exception(error.message);
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
