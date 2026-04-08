import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

import 'package:search/highest_rated/highest_rated_state.dart';

class HighestRatedCubit extends Cubit<HighestRatedState> {
  final DiscoverMovies _discoverMovies;

  int _totalPages = 1;

  late final PagingController<int, Movie> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) return null;
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  HighestRatedCubit(this._discoverMovies)
      : super(const HighestRatedSuccess());

  Future<List<Movie>> _fetchPage(int page) async {
    final result = await _discoverMovies(
      DiscoverMoviesParams(
        page: page,
        sortBy: 'vote_average.desc',
        voteCountGte: 200,
      ),
    );

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
