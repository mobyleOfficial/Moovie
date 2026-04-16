import 'package:core/core.dart';
import 'package:movies_data/models/local/local_movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:user_activities_data/datasources/local/user_activities_local_data_source.dart';
import 'package:user_activities_data/datasources/remote/user_activities_remote_data_source.dart';
import 'package:user_activities_domain/models/user_activity.dart';
import 'package:user_activities_domain/models/user_activity_listing.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class UserActivitiesRepositoryImpl implements UserActivitiesRepository {
  final UserActivitiesRemoteDataSource _remoteDataSource;
  final UserActivitiesLocalDataSource _localDataSource;

  UserActivitiesRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<List<UserActivity>>> getUserActivities({
    required String userId,
  }) async {
    final result = await _remoteDataSource.getUserActivities(userId: userId);

    return switch (result) {
      Success(:final data) =>
        Success(data.map((activity) => activity.toDomain()).toList()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<UserActivityListing>> getFriendsActivities({
    required int page,
  }) async {
    final result = await _remoteDataSource.getFriendsActivities(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Result<void> upsertMovieReview({
    required MovieReviewDraft draft,
    required MovieReviewStatus status,
  }) =>
      _localDataSource
          .upsertMovieReviewDraft(LocalMovieReviewDraft.fromDomain(draft, status));

  @override
  Stream<List<MovieReviewDraft>> observeMovieReviewDraftsList() =>
      _localDataSource.observeDraftsList().map(
            (localDrafts) =>
                localDrafts.map((draft) => draft.toDomain()).toList(),
          );

  @override
  Result<void> deleteDraft({required int movieId}) =>
      _localDataSource.deleteDraftByMovieId(movieId);
}
