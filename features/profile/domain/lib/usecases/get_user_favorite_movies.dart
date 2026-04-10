import 'package:core/core.dart';
import 'package:movies_domain/models/movie_listing.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class GetUserFavoriteMoviesParams {
  final String userId;
  final int page;

  const GetUserFavoriteMoviesParams({
    required this.userId,
    required this.page,
  });
}

class GetUserFavoriteMovies
    extends UseCase<GetUserFavoriteMoviesParams, Result<MovieListing>> {
  final ProfileRepository _profileRepository;

  GetUserFavoriteMovies(this._profileRepository);

  @override
  Future<Result<MovieListing>> call([
    GetUserFavoriteMoviesParams? params,
  ]) async =>
      _profileRepository.getUserFavoriteMovies(
        userId: params?.userId ?? '',
        page: params?.page ?? 1,
      );
}
