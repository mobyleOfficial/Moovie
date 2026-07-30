import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';

import 'package:profile_ui/tabs/lists/user_movie_lists_state.dart';

class UserMovieListsCubit extends Cubit<UserMovieListsState> {
  final GetMovieLists _getMovieLists;
  final String userId;

  int _totalPages = 1;

  late final PagingController<int, MovieList> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) return null;
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  UserMovieListsCubit(this._getMovieLists, {required this.userId})
      : super(const UserMovieListsSuccess());

  Future<List<MovieList>> _fetchPage(int page) async {
    final result = await _getMovieLists(
      GetMovieListsParams(page: page, userId: userId),
    );

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.lists;
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
