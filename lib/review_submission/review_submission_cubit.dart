import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovie/review_submission/review_submission_state.dart';
import 'package:moovie/worker/review_submission_worker.dart';
import 'package:movies/movies.dart';
import 'package:user_activities/user_activities.dart';

class ReviewSubmissionCubit extends Cubit<ReviewSubmissionState> {
  final ObserveSubmittingDrafts _observeSubmittingDrafts;
  final DeleteDraft _deleteDraft;

  late final StreamSubscription<List<MovieReviewDraft>> _subscription;
  final Set<int> _scheduledWorkers = {};

  ReviewSubmissionCubit(
    this._observeSubmittingDrafts,
    this._deleteDraft,
  ) : super(const ReviewSubmissionIdle()) {
    _subscription = _observeSubmittingDrafts().listen(_onDraftsChanged);
  }

  void _onDraftsChanged(List<MovieReviewDraft> drafts) {
    for (final draft in drafts) {
      if (draft.status == MovieReviewStatus.submitting &&
          !_scheduledWorkers.contains(draft.movieId)) {
        _scheduledWorkers.add(draft.movieId);
        scheduleReviewSubmission(movieId: draft.movieId);
      }
    }

    if (drafts.isEmpty) {
      emit(const ReviewSubmissionIdle());
    } else {
      emit(ReviewSubmissionActive(drafts));
    }
  }

  Future<void> dismissError(int movieId) async {
    await _deleteDraft(movieId);
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
