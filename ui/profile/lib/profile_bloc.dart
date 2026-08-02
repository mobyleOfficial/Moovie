import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfile _getUserProfile;
  StreamSubscription<UserProfile>? _subscription;

  ProfileCubit({
    required GetUserProfile getUserProfile,
  })  : _getUserProfile = getUserProfile,
        super(const ProfileLoading()) {
    _subscription = _getUserProfile().listen(
      (profile) => emit(ProfileSuccess(profile)),
    );
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
    _subscription?.cancel();
    return super.close();
  }
}
