import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:user_activities/user_activities.dart';

@module
abstract class UserActivitiesModule {
  @lazySingleton
  UserActivitiesRemoteDataSource userActivitiesRemoteDataSource(
    @Named('tmdb') HttpClient httpClient,
  ) =>
      UserActivitiesRemoteDataSourceImpl(httpClient);

  @lazySingleton
  UserActivitiesRepository userActivitiesRepository(
    UserActivitiesRemoteDataSource remoteDataSource,
  ) =>
      UserActivitiesRepositoryImpl(remoteDataSource);

  @injectable
  GetUserActivities getUserActivities(UserActivitiesRepository repository) =>
      GetUserActivities(repository);
}
