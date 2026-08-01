sealed class WatchlistState {
  const WatchlistState();
}

class WatchlistLoading extends WatchlistState {
  const WatchlistLoading();
}

class WatchlistSuccess extends WatchlistState {
  const WatchlistSuccess();
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);
}
