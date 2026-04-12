import 'package:core/core.dart';
import 'package:user_activities_data/models/remote/remote_user_activity.dart';

abstract interface class UserActivitiesRemoteDataSource {
  Future<Result<List<RemoteUserActivity>>> getUserActivities({required String userId});
}
