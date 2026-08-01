import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/tabs/watchlist/watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  final GetUserWatchList _getUserWatchList;
  final GetUserProfile _getUserProfile;

  String? _userId;
  int _totalPages = 1;

  late final PagingController<int, Movie> pagingController = PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) return null;
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  WatchlistCubit({
    required GetUserWatchList getUserWatchList,
    required GetUserProfile getUserProfile,
  })  : _getUserWatchList = getUserWatchList,
        _getUserProfile = getUserProfile,
        super(const WatchlistSuccess());

  Future<List<Movie>> _fetchPage(int page) async {
    final userId = await _resolveUserId();
    if (userId == null) throw Exception('Failed to load user profile');

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

  Future<String?> _resolveUserId() async {
    if (_userId != null) return _userId;

    final result = await _getUserProfile();
    if (result is Success<UserProfile>) {
      _userId = result.data.id;
    }
    return _userId;
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
