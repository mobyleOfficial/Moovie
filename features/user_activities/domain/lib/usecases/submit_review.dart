import 'package:core/core.dart';
import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class SubmitReview extends UseCase<MovieReviewDraft, Result<void>> {
  final UserActivitiesRepository _repository;

  SubmitReview(this._repository);

  @override
  Future<Result<void>> call([MovieReviewDraft? params]) async {
    if (params == null) return const Failure(AppError.unknown);

    _repository.updateDraftStatus(
      movieId: params.movieId,
      status: MovieReviewStatus.submitting,
    );

    final result = await _repository.submitReview(draft: params);

    return switch (result) {
      Success() => () {
          _repository.deleteDraft(movieId: params.movieId);
          return const Success(null);
        }(),
      Failure(:final error) => () {
          _repository.updateDraftStatus(
            movieId: params.movieId,
            status: MovieReviewStatus.error,
          );
          return Failure(error);
        }(),
    };
  }
}
