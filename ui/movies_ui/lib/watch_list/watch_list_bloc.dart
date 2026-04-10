import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/watch_list/watch_list_state.dart';

class WatchListCubit extends Cubit<WatchListState> {
  final GetUserWatchList _getUserWatchList;
  final String userId;

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

  WatchListCubit({
    required GetUserWatchList getUserWatchList,
    required this.userId,
  })  : _getUserWatchList = getUserWatchList,
        super(const WatchListLoading());

  Future<List<Movie>> _fetchPage(int page) async {
    final result = await _getUserWatchList(
      GetUserWatchListParams(userId: userId, page: page),
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
