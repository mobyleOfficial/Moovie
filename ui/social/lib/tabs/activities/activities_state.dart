sealed class ActivitiesState {
  const ActivitiesState();
}

class ActivitiesLoading extends ActivitiesState {
  const ActivitiesLoading();
}

class ActivitiesSuccess extends ActivitiesState {
  const ActivitiesSuccess();
}

class ActivitiesError extends ActivitiesState {
  final String message;

  const ActivitiesError(this.message);
}
