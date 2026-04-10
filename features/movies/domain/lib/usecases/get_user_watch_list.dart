import 'package:core/core.dart';
import 'package:movies_domain/models/movie_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetUserWatchListParams {
  final String userId;
  final int page;

  const GetUserWatchListParams({
    required this.userId,
    required this.page,
  });
}

class GetUserWatchList
    extends UseCase<GetUserWatchListParams, Result<MovieListing>> {
  final MoviesRepository _moviesRepository;

  GetUserWatchList(this._moviesRepository);

  @override
  Future<Result<MovieListing>> call([
    GetUserWatchListParams? params,
  ]) async =>
      _moviesRepository.getUserWatchList(
        userId: params?.userId ?? '',
        page: params?.page ?? 1,
      );
}
