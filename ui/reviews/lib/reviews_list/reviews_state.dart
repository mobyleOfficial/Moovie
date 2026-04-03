sealed class ReviewsState {
  const ReviewsState();
}

class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

class ReviewsSuccess extends ReviewsState {
  const ReviewsSuccess();
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError(this.message);
}