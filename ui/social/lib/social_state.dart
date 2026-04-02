sealed class SocialState {
  const SocialState();
}

class SocialLoading extends SocialState {
  const SocialLoading();
}

class SocialSuccess extends SocialState {
  const SocialSuccess();
}

class SocialError extends SocialState {
  final String message;

  const SocialError(this.message);
}
