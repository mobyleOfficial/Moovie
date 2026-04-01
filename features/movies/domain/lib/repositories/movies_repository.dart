import 'package:core/core.dart';

import '../models/trending_movie_listing.dart';

abstract interface class MoviesRepository {
  Future<Result<TrendingMovieListing>> getTrendingMovieList({required int page});
}