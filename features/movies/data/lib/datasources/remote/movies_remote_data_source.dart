import 'package:core/core.dart';

import 'package:movies_data/models/remote/remote_movie_collection_listing.dart';
import 'package:movies_data/models/remote/remote_movie_list_detail.dart';
import 'package:movies_data/models/remote/remote_movie_list_listing.dart';
import 'package:movies_data/models/remote/remote_movie_detail.dart';
import 'package:movies_data/models/remote/remote_movie_review_listing.dart';
import 'package:movies_data/models/remote/remote_country.dart';
import 'package:movies_data/models/remote/remote_genre.dart';
import 'package:movies_data/models/remote/remote_language.dart';
import 'package:movies_data/models/remote/remote_movie_listing.dart';

abstract interface class MoviesRemoteDataSource {
  Future<Result<RemoteMovieListing>> getTrendingMovieList({required int page});
  Future<Result<RemoteMovieDetail>> getMovieDetail({required int movieId});
  Future<Result<RemoteMovieReviewListing>> getMovieReviews({required int page});
  Future<Result<RemoteMovieCollectionListing>> getMovieCollections({required int page});
  Future<Result<RemoteMovieListListing>> getMovieLists({required int page});
  Future<Result<RemoteMovieListDetail>> getMovieListDetail({required int listId, required int page});
  Future<Result<RemoteMovieListing>> searchMovies({required String query, required int page});
  Future<Result<RemoteMovieListing>> discoverMovies({
    required int page,
    int? primaryReleaseYear,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
    String? withGenres,
    String? withOriginalLanguage,
    String? withOriginCountry,
  });
  Future<Result<List<RemoteGenre>>> getGenres();
  Future<Result<List<RemoteCountry>>> getCountries();
  Future<Result<List<RemoteLanguage>>> getLanguages();
}
