import 'package:core/core.dart';

import 'package:movies_domain/models/movie_collection_listing.dart';
import 'package:movies_domain/models/movie_list_detail.dart';
import 'package:movies_domain/models/movie_list_listing.dart';
import 'package:movies_domain/models/movie_detail.dart';
import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_listing.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:movies_domain/models/recent_search.dart';
import 'package:movies_domain/models/country.dart';
import 'package:movies_domain/models/genre.dart';
import 'package:movies_domain/models/language.dart';
import 'package:movies_domain/models/movie_listing.dart';

abstract interface class MoviesRepository {
  Future<Result<MovieListing>> getTrendingMovieList({required int page});
  Future<Result<MovieDetail>> getMovieDetail({required int movieId});
  Future<Result<MovieReviewListing>> getMovieReviews({required int page});
  Future<Result<MovieCollectionListing>> getMovieCollections({required int page});
  Future<Result<MovieListListing>> getMovieLists({required int page});
  Future<Result<MovieListListing>> getUserMovieLists({required int page});
  Future<Result<MovieListDetail>> getMovieListDetail({required int listId, required int page});
  Future<Result<MovieListing>> searchMovies({required String query, required int page});
  Future<Result<MovieListing>> discoverMovies({
    required int page,
    int? primaryReleaseYear,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
    String? withGenres,
    String? withOriginalLanguage,
    String? withOriginCountry,
    int? minimumVoteCount,
  });
  Future<Result<List<Genre>>> getGenres();
  Future<Result<List<Country>>> getCountries();
  Future<Result<List<Language>>> getLanguages();
  Result<void> upsertMovieReview({required MovieReviewDraft draft, required MovieReviewStatus status});
  Stream<List<MovieReviewDraft>> observeMovieReviewDraftsList();
  Result<void> deleteDraft({required int movieId});
  Result<void> addRecentSearch({required String query});
  Stream<List<RecentSearch>> observeRecentSearches();
  Future<Result<MovieListing>> getUserWatchList({required String userId, required int page});
}
