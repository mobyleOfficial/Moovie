sealed class NewUserActivityState {
  const NewUserActivityState();
}

class NewUserActivityLoading extends NewUserActivityState {
  const NewUserActivityLoading();
}

class NewUserActivitySuccess extends NewUserActivityState {
  const NewUserActivitySuccess();
}

class NewUserActivityError extends NewUserActivityState {
  final String message;

  const NewUserActivityError(this.message);
}
