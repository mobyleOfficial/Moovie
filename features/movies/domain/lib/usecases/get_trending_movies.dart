import 'package:core/core.dart';

import 'package:movies_domain/models/trending_movie_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetTrendingMovies extends UseCase<int, Result<TrendingMovieListing>> {
  final MoviesRepository _moviesRepository;

  GetTrendingMovies(this._moviesRepository);

  @override
  Future<Result<TrendingMovieListing>> call([int? params]) async {
    return _moviesRepository.getTrendingMovieList(page: params ?? 1);
  }
}