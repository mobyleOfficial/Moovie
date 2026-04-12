import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:public_profile_feature/public_profile_feature.dart';

@module
abstract class PublicProfileModule {
  @lazySingleton
  PublicProfileRemoteDataSource publicProfileRemoteDataSource(
    @Named('tmdb') HttpClient httpClient,
  ) =>
      PublicProfileRemoteDataSourceImpl(httpClient);

  @lazySingleton
  PublicProfileRepository publicProfileRepository(
    PublicProfileRemoteDataSource remoteDataSource,
  ) =>
      PublicProfileRepositoryImpl(remoteDataSource);

  @injectable
  GetPublicProfile getPublicProfile(PublicProfileRepository repository) =>
      GetPublicProfile(repository);
}
