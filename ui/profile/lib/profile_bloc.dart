import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfile _getUserProfile;

  ProfileCubit(this._getUserProfile) : super(const ProfileLoading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    emit(const ProfileLoading());
    final result = await _getUserProfile();

    switch (result) {
      case Success(:final data):
        emit(ProfileSuccess(data));
      case Failure(:final error):
        emit(ProfileError(error.message));
    }
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
}
