sealed class WatchListState {
  const WatchListState();
}

class WatchListLoading extends WatchListState {
  const WatchListLoading();
}

class WatchListSuccess extends WatchListState {
  const WatchListSuccess();
}

class WatchListError extends WatchListState {
  final String message;

  const WatchListError(this.message);
}
