import 'package:core/core.dart';

import 'package:movies_domain/models/movie_collection_listing.dart';
import 'package:movies_domain/models/movie_list_listing.dart';
import 'package:movies_domain/models/movie_detail.dart';
import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_listing.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:movies_domain/models/recent_search.dart';
import 'package:movies_domain/models/trending_movie_listing.dart';

abstract interface class MoviesRepository {
  Future<Result<TrendingMovieListing>> getTrendingMovieList({required int page});
  Future<Result<MovieDetail>> getMovieDetail({required int movieId});
  Future<Result<MovieReviewListing>> getMovieReviews({required int page});
  Future<Result<MovieCollectionListing>> getMovieCollections({required int page});
  Future<Result<MovieListListing>> getMovieLists({required int page});
  Future<Result<TrendingMovieListing>> searchMovies({required String query, required int page});
  Result<void> upsertMovieReview({required MovieReviewDraft draft, required MovieReviewStatus status});
  Stream<List<MovieReviewDraft>> observeMovieReviewDraftsList();
  Result<void> deleteDraft({required int movieId});
  Result<void> addRecentSearch({required String query});
  Stream<List<RecentSearch>> observeRecentSearches();
}
