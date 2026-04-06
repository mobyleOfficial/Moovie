import 'package:core/core.dart';

import 'package:movies_domain/models/movie_review_draft.dart';
import 'package:movies_domain/models/movie_review_status.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class UpsertMovieReviewParams {
  final MovieReviewDraft draft;
  final MovieReviewStatus status;

  const UpsertMovieReviewParams({
    required this.draft,
    required this.status,
  });
}

class UpsertMovieReview extends UseCase<UpsertMovieReviewParams, Result<void>> {
  final MoviesRepository _moviesRepository;

  UpsertMovieReview(this._moviesRepository);

  @override
  Future<Result<void>> call([UpsertMovieReviewParams? params]) async =>
      _moviesRepository.upsertMovieReview(
        draft: params!.draft,
        status: params.status,
      );
}
