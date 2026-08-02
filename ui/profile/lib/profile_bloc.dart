import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfile _getUserProfile;
  StreamSubscription<UserProfile>? _subscription;

  ProfileCubit({
    required GetUserProfile getUserProfile,
  })  : _getUserProfile = getUserProfile,
        super(const ProfileLoading());

  void listen() {
    _subscription?.cancel();
    dev.log('[ProfileWS] Subscribing to profile stream');
    _subscription = _getUserProfile().listen(
      (profile) {
        dev.log('[ProfileWS] Profile received: ${profile.username}, isScraping=${profile.isScraping}, isClosed=$isClosed');
        if (!isClosed) {
          emit(ProfileSuccess(profile));
          dev.log('[ProfileWS] State emitted: ${state.runtimeType}');
        }
      },
      onError: (error) {
        dev.log('[ProfileWS] Profile stream error: $error');
        emit(const ProfileError(""));
      },
      onDone: () {
        dev.log('[ProfileWS] Profile stream closed (onDone)');
      },
    );
  }

  void retry() {
    // TBD
  }

  void updateProfile(UserProfile updated) {
    final current = state;
    if (current is ProfileSuccess) {
      emit(ProfileSuccess(current.profile.copyWith(
        photoUrl: updated.photoUrl,
        username: updated.username,
        bio: updated.bio,
      )));
    }
  }

  @override
  Future<void> close() {
    dev.log('[ProfileWS] ProfileCubit closing');
    _subscription?.cancel();
    return super.close();
  }
}
