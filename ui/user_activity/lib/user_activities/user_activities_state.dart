import 'package:user_activities_domain/models/user_activity.dart';

sealed class UserActivitiesState {
  const UserActivitiesState();
}

class UserActivitiesLoading extends UserActivitiesState {
  const UserActivitiesLoading();
}

class UserActivitiesSuccess extends UserActivitiesState {
  final List<UserActivity> activities;

  const UserActivitiesSuccess(this.activities);
}

class UserActivitiesError extends UserActivitiesState {
  final String message;

  const UserActivitiesError(this.message);
}
