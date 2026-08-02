import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muuvie/routes/main_state.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';
import 'package:user_activities/user_activities.dart';

class MainCubit extends Cubit<MainState> {
  final ObserveSubmittingDrafts _observeSubmittingDrafts;
  final DeleteDraft _deleteDraft;

  late final StreamSubscription<List<MovieReviewDraft>> _draftsSubscription;
  late final StreamSubscription<UserProfile> _profileSubscription;

  List<MovieReviewDraft> _drafts = const [];
  bool _isScraping = false;

  MainCubit(
    this._observeSubmittingDrafts,
    this._deleteDraft,
    ObserveUserProfile getUserProfile,
  ) : super(const MainLoading()) {
    _draftsSubscription = _observeSubmittingDrafts().listen(_onDraftsChanged);
    _profileSubscription = getUserProfile().listen(_onProfileChanged);
  }

  void _onDraftsChanged(List<MovieReviewDraft> drafts) {
    _drafts = drafts;
    _emitSuccess();
  }

  void _onProfileChanged(UserProfile profile) {
    _isScraping = profile.isScraping;
    _emitSuccess();
  }

  void _emitSuccess() =>
      emit(MainSuccess(submittingDrafts: _drafts, isScraping: _isScraping));

  Future<void> dismissError(int movieId) async =>
      _deleteDraft(movieId);

  @override
  Future<void> close() {
    _draftsSubscription.cancel();
    _profileSubscription.cancel();
    return super.close();
  }
}
