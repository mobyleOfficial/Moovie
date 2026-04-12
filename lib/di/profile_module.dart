import 'package:injectable/injectable.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';

@module
abstract class ProfileModule {
  @lazySingleton
  ProfileRepository profileRepository(
    MoviesRemoteDataSource moviesRemoteDataSource,
  ) =>
      ProfileRepositoryImpl(moviesRemoteDataSource);

  @injectable
  GetUserReviews getUserReviews(ProfileRepository repository) =>
      GetUserReviews(repository);

  @injectable
  GetUserFavoriteMovies getUserFavoriteMovies(ProfileRepository repository) =>
      GetUserFavoriteMovies(repository);
}
