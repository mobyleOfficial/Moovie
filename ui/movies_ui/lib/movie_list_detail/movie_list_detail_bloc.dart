import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_state.dart';

class MovieListDetailCubit extends Cubit<MovieListDetailState> {
  final GetMovieListDetail _getMovieListDetail;
  final int listId;

  int _totalPages = 1;
  bool _initialLoaded = false;

  late final PagingController<int, Movie> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) return null;
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  MovieListDetailCubit(this._getMovieListDetail, this.listId)
      : super(const MovieListDetailLoading()) {
    _fetchInitial();
  }

  void reload() {
    emit(const MovieListDetailLoading());
    _fetchInitial();
  }

  Future<void> _fetchInitial() async {
    final result = await _getMovieListDetail(
      GetMovieListDetailParams(listId: listId, page: 1),
    );

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        _initialLoaded = true;
        emit(MovieListDetailSuccess(
          detail: data,
          isLiked: data.isLiked,
          likesCount: data.likesCount,
        ));
        // Seed the paging controller with the first page
        pagingController.value = PagingState<int, Movie>(
          pages: [data.movies],
          keys: const [1],
        );
      case Failure(:final error):
        emit(MovieListDetailError(error.message));
    }
  }

  Future<List<Movie>> _fetchPage(int page) async {
    // Skip page 1 if already loaded by _fetchInitial
    if (page == 1 && _initialLoaded) return [];

    final result = await _getMovieListDetail(
      GetMovieListDetailParams(listId: listId, page: page),
    );

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.movies;
      case Failure(:final error):
        throw Exception(error.message);
    }
  }

  void toggleViewMode() {
    final current = state;
    if (current is MovieListDetailSuccess) {
      emit(current.copyWith(isGridView: !current.isGridView));
    }
  }

  void toggleLike() {
    final current = state;
    if (current is MovieListDetailSuccess) {
      final newIsLiked = !current.isLiked;
      emit(current.copyWith(
        isLiked: newIsLiked,
        likesCount: current.likesCount + (newIsLiked ? 1 : -1),
      ));
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}