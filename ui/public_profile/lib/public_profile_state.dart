sealed class PublicProfileState {
  const PublicProfileState();
}

class PublicProfileLoading extends PublicProfileState {
  const PublicProfileLoading();
}

class PublicProfileSuccess extends PublicProfileState {
  const PublicProfileSuccess();
}

class PublicProfileError extends PublicProfileState {
  final String message;
  const PublicProfileError(this.message);
}
