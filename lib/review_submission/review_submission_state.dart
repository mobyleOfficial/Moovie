import 'package:movies/movies.dart';

sealed class ReviewSubmissionState {
  const ReviewSubmissionState();
}

class ReviewSubmissionIdle extends ReviewSubmissionState {
  const ReviewSubmissionIdle();
}

class ReviewSubmissionActive extends ReviewSubmissionState {
  final List<MovieReviewDraft> drafts;

  const ReviewSubmissionActive(this.drafts);

  bool get hasSubmitting =>
      drafts.any((draft) => draft.status == MovieReviewStatus.submitting);

  bool get hasError =>
      drafts.any((draft) => draft.status == MovieReviewStatus.error);

  MovieReviewDraft? get firstSubmitting => drafts
      .where((draft) => draft.status == MovieReviewStatus.submitting)
      .firstOrNull;

  MovieReviewDraft? get firstError => drafts
      .where((draft) => draft.status == MovieReviewStatus.error)
      .firstOrNull;
}
