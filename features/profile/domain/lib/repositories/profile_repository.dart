import 'package:core/core.dart';
import 'package:movies_domain/models/movie_listing.dart';
import 'package:movies_domain/models/movie_review_listing.dart';

abstract interface class ProfileRepository {
  Future<Result<MovieReviewListing>> getUserReviews({required int page});
  Future<Result<MovieListing>> getUserFavoriteMovies({required String userId, required int page});
}
