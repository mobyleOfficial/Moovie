import 'package:core/core.dart';
import 'package:profile_data/datasources/profile_remote_data_source.dart';
import 'package:profile_domain/models/user_profile.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final HttpClient _httpClient;

  ProfileRemoteDataSourceImpl(this._httpClient);

  @override
  Future<Result<void>> updateUserProfile({
    required UserProfile profile,
  }) async =>
      const Success(null);
}
