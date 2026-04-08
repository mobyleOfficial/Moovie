import 'package:core/core.dart';

import 'package:movies_domain/models/movie_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetTrendingMovies extends UseCase<int, Result<MovieListing>> {
  final MoviesRepository _moviesRepository;

  GetTrendingMovies(this._moviesRepository);

  @override
  Future<Result<MovieListing>> call([int? params]) async {
    return _moviesRepository.getTrendingMovieList(page: params ?? 1);
  }
}