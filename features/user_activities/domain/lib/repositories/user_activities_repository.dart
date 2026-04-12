import 'package:core/core.dart';
import 'package:user_activities_domain/models/user_activity.dart';

abstract interface class UserActivitiesRepository {
  Future<Result<List<UserActivity>>> getUserActivities({required String userId});
}
