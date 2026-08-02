import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';

@module
abstract class ProfileModule {
  @lazySingleton
  ProfileRemoteDataSource profileRemoteDataSource(
    @Named('backend') HttpClient httpClient,
  ) =>
      ProfileRemoteDataSourceImpl(httpClient);

  @lazySingleton
  ProfileRepository profileRepository(
    MoviesRemoteDataSource moviesRemoteDataSource,
    ProfileRemoteDataSource profileRemoteDataSource,
    WebSocketClient webSocketClient,
  ) =>
      ProfileRepositoryImpl(
        moviesRemoteDataSource,
        profileRemoteDataSource,
        webSocketClient,
      );

  @injectable
  GetUserReviews getUserReviews(ProfileRepository repository) =>
      GetUserReviews(repository);

  @injectable
  GetUserFavoriteMovies getUserFavoriteMovies(ProfileRepository repository) =>
      GetUserFavoriteMovies(repository);

  @injectable
  UpdateUserProfile updateUserProfile(ProfileRepository repository) =>
      UpdateUserProfile(repository);

  @injectable
  GetUserProfile getUserProfile(ProfileRepository repository) =>
      GetUserProfile(repository);

  @injectable
  StartScrape startScrape(ProfileRepository repository) =>
      StartScrape(repository);
}
