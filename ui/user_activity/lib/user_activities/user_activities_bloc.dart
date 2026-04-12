import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_activity/user_activities/user_activities_state.dart';
import 'package:user_activities_domain/usecases/get_user_activities.dart';

class UserActivitiesCubit extends Cubit<UserActivitiesState> {
  final GetUserActivities _getUserActivities;
  final String userId;

  UserActivitiesCubit({
    required GetUserActivities getUserActivities,
    required this.userId,
  })  : _getUserActivities = getUserActivities,
        super(const UserActivitiesLoading()) {
    _load();
  }

  Future<void> _load() async {
    final result = await _getUserActivities(userId);

    switch (result) {
      case Success(:final data):
        emit(UserActivitiesSuccess(data));
      case Failure(:final error):
        emit(UserActivitiesError(error.message));
    }
  }
}
