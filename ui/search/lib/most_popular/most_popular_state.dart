sealed class MostPopularState {
  const MostPopularState();
}

class MostPopularLoading extends MostPopularState {
  const MostPopularLoading();
}

class MostPopularSuccess extends MostPopularState {
  const MostPopularSuccess();
}

class MostPopularError extends MostPopularState {
  final String message;

  const MostPopularError(this.message);
}
