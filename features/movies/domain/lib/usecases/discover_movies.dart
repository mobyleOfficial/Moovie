import 'package:core/core.dart';

import 'package:movies_domain/models/discover_movies_params.dart';
import 'package:movies_domain/models/trending_movie_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class DiscoverMovies
    extends UseCase<DiscoverMoviesParams, Result<TrendingMovieListing>> {
  final MoviesRepository _moviesRepository;

  DiscoverMovies(this._moviesRepository);

  @override
  Future<Result<TrendingMovieListing>> call([
    DiscoverMoviesParams? params,
  ]) async =>
      _moviesRepository.discoverMovies(
        page: params?.page ?? 1,
        primaryReleaseYear: params?.primaryReleaseYear,
        releaseDateGte: params?.releaseDateGte,
        releaseDateLte: params?.releaseDateLte,
        sortBy: params?.sortBy,
      );
}
