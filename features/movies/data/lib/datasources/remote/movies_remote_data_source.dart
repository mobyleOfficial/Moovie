import 'package:core/core.dart';

import 'package:movies_data/models/remote/remote_movie_collection_listing.dart';
import 'package:movies_data/models/remote/remote_movie_list_detail.dart';
import 'package:movies_data/models/remote/remote_movie_list_listing.dart';
import 'package:movies_data/models/remote/remote_movie_detail.dart';
import 'package:movies_data/models/remote/remote_movie_review_listing.dart';
import 'package:movies_data/models/remote/remote_trending_movie_listing.dart';

abstract interface class MoviesRemoteDataSource {
  Future<Result<RemoteTrendingMovieListing>> getTrendingMovieList({required int page});
  Future<Result<RemoteMovieDetail>> getMovieDetail({required int movieId});
  Future<Result<RemoteMovieReviewListing>> getMovieReviews({required int page});
  Future<Result<RemoteMovieCollectionListing>> getMovieCollections({required int page});
  Future<Result<RemoteMovieListListing>> getMovieLists({required int page});
  Future<Result<RemoteMovieListDetail>> getMovieListDetail({required int listId, required int page});
  Future<Result<RemoteTrendingMovieListing>> searchMovies({required String query, required int page});
  Future<Result<RemoteTrendingMovieListing>> discoverMovies({
    required int page,
    int? primaryReleaseYear,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
  });
}
