import 'package:profile/profile.dart';

sealed class ProfileInfoState {
  const ProfileInfoState();
}

class ProfileInfoLoading extends ProfileInfoState {
  const ProfileInfoLoading();
}

class ProfileInfoSuccess extends ProfileInfoState {
  final UserProfile profile;

  const ProfileInfoSuccess(this.profile);
}

class ProfileInfoError extends ProfileInfoState {
  final String message;

  const ProfileInfoError(this.message);
}
