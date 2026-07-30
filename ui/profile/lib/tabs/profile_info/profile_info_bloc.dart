import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/tabs/profile_info/profile_info_state.dart';

class ProfileCubit extends Cubit<ProfileInfoState> {
  final GetUserProfile _getUserProfile;

  ProfileCubit(this._getUserProfile) : super(const ProfileInfoLoading()) {
    loadProfile();
  }

  Future<void> loadProfile() async {
    emit(const ProfileInfoLoading());
    final result = await _getUserProfile();

    switch (result) {
      case Success(:final data):
        emit(ProfileInfoSuccess(data));
      case Failure(:final error):
        emit(ProfileInfoError(error.message));
    }
  }

  void updateProfile(UserProfile updated) {
    final current = state;
    if (current is ProfileInfoSuccess) {
      emit(ProfileInfoSuccess(current.profile.copyWith(
        photoUrl: updated.photoUrl,
        username: updated.username,
        bio: updated.bio,
      )));
    }
  }
}
