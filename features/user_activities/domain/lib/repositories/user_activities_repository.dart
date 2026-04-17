import 'package:core/core.dart';
import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:user_activities_domain/models/user_activity.dart';
import 'package:user_activities_domain/models/user_activity_listing.dart';

abstract interface class UserActivitiesRepository {
  Future<Result<List<UserActivity>>> getUserActivities({required String userId});
  Future<Result<UserActivityListing>> getFriendsActivities({required int page});
  Result<void> upsertMovieReview({required MovieReviewDraft draft, required MovieReviewStatus status});
  Stream<List<MovieReviewDraft>> observeMovieReviewDraftsList();
  Result<void> deleteDraft({required int movieId});
  Future<Result<void>> submitReview({required MovieReviewDraft draft});
  Result<void> updateDraftStatus({required int movieId, required MovieReviewStatus status});
  Stream<List<MovieReviewDraft>> observeSubmittingDrafts();
}
