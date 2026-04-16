import 'package:core/core.dart';
import 'package:user_activities_domain/models/user_activity_listing.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class GetFriendsActivities
    extends UseCase<int, Result<UserActivityListing>> {
  final UserActivitiesRepository _userActivitiesRepository;

  GetFriendsActivities(this._userActivitiesRepository);

  @override
  Future<Result<UserActivityListing>> call([int? params]) async =>
      _userActivitiesRepository.getFriendsActivities(page: params ?? 1);
}
