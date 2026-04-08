sealed class HighestRatedState {
  const HighestRatedState();
}

class HighestRatedLoading extends HighestRatedState {
  const HighestRatedLoading();
}

class HighestRatedSuccess extends HighestRatedState {
  const HighestRatedSuccess();
}

class HighestRatedError extends HighestRatedState {
  final String message;

  const HighestRatedError(this.message);
}
