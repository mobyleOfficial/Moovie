import 'package:core/core.dart';
import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:user_activities_domain/repositories/user_activities_repository.dart';

class UpsertMovieReviewParams {
  final MovieReviewDraft draft;
  final MovieReviewStatus status;

  const UpsertMovieReviewParams({
    required this.draft,
    required this.status,
  });
}

class UpsertMovieReview extends UseCase<UpsertMovieReviewParams, Result<void>> {
  final UserActivitiesRepository _userActivitiesRepository;

  UpsertMovieReview(this._userActivitiesRepository);

  @override
  Future<Result<void>> call([UpsertMovieReviewParams? params]) async {
    if (params == null) return const Failure(AppError.unknown);
    return _userActivitiesRepository.upsertMovieReview(
      draft: params.draft,
      status: params.status,
    );
  }
}
