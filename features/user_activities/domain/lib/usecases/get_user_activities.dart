import 'package:core/core.dart';
import 'package:user_activities_domain/models/user_activity.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class GetUserActivities
    extends UseCase<String, Result<List<UserActivity>>> {
  final UserActivitiesRepository _userActivitiesRepository;

  GetUserActivities(this._userActivitiesRepository);

  @override
  Future<Result<List<UserActivity>>> call([String? params]) async =>
      _userActivitiesRepository.getUserActivities(userId: params ?? '');
}
