import 'package:core/core.dart';
import 'package:user_activities_data/datasources/remote/user_activities_remote_data_source.dart';
import 'package:user_activities_domain/models/user_activity.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class UserActivitiesRepositoryImpl implements UserActivitiesRepository {
  final UserActivitiesRemoteDataSource _remoteDataSource;

  UserActivitiesRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<UserActivity>>> getUserActivities({
    required String userId,
  }) async {
    final result = await _remoteDataSource.getUserActivities(userId: userId);

    return switch (result) {
      Success(:final data) =>
        Success(data.map((activity) => activity.toDomain()).toList()),
      Failure(:final error) => Failure(error),
    };
  }
}
