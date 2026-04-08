import 'package:core/core.dart';

import 'package:movies_domain/models/discover_movies_params.dart';
import 'package:movies_domain/models/movie_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class DiscoverMovies
    extends UseCase<DiscoverMoviesParams, Result<MovieListing>> {
  final MoviesRepository _moviesRepository;

  DiscoverMovies(this._moviesRepository);

  @override
  Future<Result<MovieListing>> call([
    DiscoverMoviesParams? params,
  ]) async =>
      _moviesRepository.discoverMovies(
        page: params?.page ?? 1,
        primaryReleaseYear: params?.primaryReleaseYear,
        releaseDateGte: params?.releaseDateGte,
        releaseDateLte: params?.releaseDateLte,
        sortBy: params?.sortBy,
        withGenres: params?.withGenres,
        withOriginalLanguage: params?.withOriginalLanguage,
        withOriginCountry: params?.withOriginCountry,
        voteCountGte: params?.voteCountGte,
      );
}
