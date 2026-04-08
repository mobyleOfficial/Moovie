import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

import 'package:search/release_date/movies/release_date_movies_state.dart';

class ReleaseDateMoviesCubit extends Cubit<ReleaseDateMoviesState> {
  final DiscoverMovies _discoverMovies;
  final int? primaryReleaseYear;
  final String? releaseDateGte;
  final String? releaseDateLte;
  final String? sortBy;

  int _totalPages = 1;

  late final PagingController<int, Movie> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) return null;
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  ReleaseDateMoviesCubit(
    this._discoverMovies, {
    this.primaryReleaseYear,
    this.releaseDateGte,
    this.releaseDateLte,
    this.sortBy,
  }) : super(const ReleaseDateMoviesSuccess());

  Future<List<Movie>> _fetchPage(int page) async {
    final result = await _discoverMovies(
      DiscoverMoviesParams(
        page: page,
        primaryReleaseYear: primaryReleaseYear,
        releaseDateGte: releaseDateGte,
        releaseDateLte: releaseDateLte,
        sortBy: sortBy,
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
