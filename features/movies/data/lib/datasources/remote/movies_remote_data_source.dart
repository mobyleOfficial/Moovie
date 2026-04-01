import 'package:core/core.dart';

import '../../models/remote/remote_trending_movie_listing.dart';

abstract interface class MoviesRemoteDataSource {
  Future<Result<RemoteTrendingMovieListing>> getTrendingMovieList({required int page});
}