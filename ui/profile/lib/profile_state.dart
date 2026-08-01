import 'package:profile/profile.dart';

sealed class ProfileState {
  const ProfileState();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileSuccess extends ProfileState {
  final UserProfile profile;

  const ProfileSuccess(this.profile);
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
