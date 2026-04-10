import 'package:core/core.dart';
import 'package:movies_domain/models/movie_review_listing.dart';

abstract interface class ProfileRepository {
  Future<Result<MovieReviewListing>> getUserReviews({required int page});
}
