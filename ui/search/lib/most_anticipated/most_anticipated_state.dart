sealed class MostAnticipatedState {
  const MostAnticipatedState();
}

class MostAnticipatedLoading extends MostAnticipatedState {
  const MostAnticipatedLoading();
}

class MostAnticipatedSuccess extends MostAnticipatedState {
  const MostAnticipatedSuccess();
}

class MostAnticipatedError extends MostAnticipatedState {
  final String message;

  const MostAnticipatedError(this.message);
}
