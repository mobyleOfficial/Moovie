import 'package:core/core.dart';
import 'package:public_profile_data/datasources/remote/public_profile_remote_data_source.dart';
import 'package:public_profile_domain/models/public_profile.dart';
import 'package:public_profile_domain/repositories/public_profile_repository.dart';

class PublicProfileRepositoryImpl implements PublicProfileRepository {
  final PublicProfileRemoteDataSource _remoteDataSource;

  PublicProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<PublicProfile>> getPublicProfile({
    required String userId,
  }) async {
    final result = await _remoteDataSource.getPublicProfile(userId: userId);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }
}
