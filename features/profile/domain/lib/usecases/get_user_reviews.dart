import 'package:core/core.dart';
import 'package:movies_domain/models/movie_review_listing.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class GetUserReviews extends UseCase<int, Result<MovieReviewListing>> {
  final ProfileRepository _profileRepository;

  GetUserReviews(this._profileRepository);

  @override
  Future<Result<MovieReviewListing>> call([int? params]) async =>
      _profileRepository.getUserReviews(page: params ?? 1);
}
