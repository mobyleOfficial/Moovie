import 'package:core/core.dart';
import 'package:user_activities_data/datasources/remote/user_activities_remote_data_source.dart';
import 'package:user_activities_data/models/remote/remote_user_activity.dart';

class UserActivitiesRemoteDataSourceImpl
    implements UserActivitiesRemoteDataSource {
  final HttpClient _httpClient;

  UserActivitiesRemoteDataSourceImpl(this._httpClient);

  static const _mockedActivities = [
    RemoteUserActivity(action: 'Watched', movie: 'Dune: Part Two', time: '2h ago'),
    RemoteUserActivity(action: 'Reviewed', movie: 'Oppenheimer', time: '1d ago'),
    RemoteUserActivity(action: 'Added to watchlist', movie: 'The Brutalist', time: '2d ago'),
    RemoteUserActivity(action: 'Liked review of', movie: 'Anora', time: '3d ago'),
    RemoteUserActivity(action: 'Watched', movie: 'Poor Things', time: '4d ago'),
    RemoteUserActivity(action: 'Reviewed', movie: 'The Substance', time: '5d ago'),
    RemoteUserActivity(action: 'Watched', movie: 'Nosferatu', time: '6d ago'),
    RemoteUserActivity(action: 'Added to watchlist', movie: 'A Real Pain', time: '1w ago'),
  ];

  @override
  Future<Result<List<RemoteUserActivity>>> getUserActivities({
    required String userId,
  }) async =>
      const Success(_mockedActivities);
}
