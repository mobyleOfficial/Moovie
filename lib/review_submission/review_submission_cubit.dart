import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moovie/review_submission/review_submission_state.dart';
import 'package:movies/movies.dart';
import 'package:user_activities/user_activities.dart';

class ReviewSubmissionCubit extends Cubit<ReviewSubmissionState> {
  final ObserveSubmittingDrafts _observeSubmittingDrafts;
  final DeleteDraft _deleteDraft;

  late final StreamSubscription<List<MovieReviewDraft>> _subscription;

  ReviewSubmissionCubit(
    this._observeSubmittingDrafts,
    this._deleteDraft,
  ) : super(const ReviewSubmissionIdle()) {
    _subscription = _observeSubmittingDrafts().listen(_onDraftsChanged);
  }

  void _onDraftsChanged(List<MovieReviewDraft> drafts) {
    if (drafts.isEmpty) {
      emit(const ReviewSubmissionIdle());
    } else {
      emit(ReviewSubmissionActive(drafts));
    }
  }

  Future<void> dismissError(int movieId) async =>
      _deleteDraft(movieId);

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
