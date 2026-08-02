sealed class EditProfileState {
  const EditProfileState();
}

class EditProfileLoading extends EditProfileState {
  const EditProfileLoading();
}

class EditProfileReady extends EditProfileState {
  final String photoUrl;
  final String username;
  final String bio;
  final bool isScraping;

  const EditProfileReady({
    required this.photoUrl,
    required this.username,
    required this.bio,
    this.isScraping = false,
  });
}

class EditProfileError extends EditProfileState {
  final String message;

  const EditProfileError(this.message);
}
