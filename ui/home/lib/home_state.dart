sealed class HomeState {
  const HomeState();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeSuccess extends HomeState {
  const HomeSuccess();
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}