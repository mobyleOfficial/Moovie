import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:social/tabs/activities/activities_state.dart';
import 'package:user_activities/user_activities.dart';

class ActivitiesCubit extends Cubit<ActivitiesState> {
  final GetFriendsActivities _getFriendsActivities;

  int _totalPages = 1;

  late final PagingController<int, UserActivity> pagingController =
      PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;
      if (nextKey > _totalPages) {
        return null;
      }
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  ActivitiesCubit(this._getFriendsActivities) : super(const ActivitiesLoading());

  Future<List<UserActivity>> _fetchPage(int page) async {
    final result = await _getFriendsActivities(page);

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.activities;
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
