import 'package:core/core.dart';

import '../models/trending_movie_listing_model.dart';

abstract interface class MoviesDataSource {
  Future<Result<TrendingMovieListingModel>> getTrendingMovieList({required int page});
}