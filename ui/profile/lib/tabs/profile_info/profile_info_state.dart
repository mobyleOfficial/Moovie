sealed class ProfileInfoState {
  const ProfileInfoState();
}

class ProfileInfoLoading extends ProfileInfoState {
  const ProfileInfoLoading();
}

class ProfileInfoSuccess extends ProfileInfoState {
  const ProfileInfoSuccess();
}

class ProfileInfoError extends ProfileInfoState {
  final String message;

  const ProfileInfoError(this.message);
}