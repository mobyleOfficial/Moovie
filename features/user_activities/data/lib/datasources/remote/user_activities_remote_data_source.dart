import 'package:core/core.dart';
import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:user_activities_data/models/remote/remote_user_activity.dart';
import 'package:user_activities_data/models/remote/remote_user_activity_listing.dart';

abstract interface class UserActivitiesRemoteDataSource {
  Future<Result<List<RemoteUserActivity>>> getUserActivities({required String userId});
  Future<Result<RemoteUserActivityListing>> getFriendsActivities({required int page});
  Future<Result<void>> submitReview({required MovieReviewDraft draft});
}
