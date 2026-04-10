sealed class UserReviewsState {
  const UserReviewsState();
}

class UserReviewsLoading extends UserReviewsState {
  const UserReviewsLoading();
}

class UserReviewsSuccess extends UserReviewsState {
  const UserReviewsSuccess();
}

class UserReviewsError extends UserReviewsState {
  final String message;

  const UserReviewsError(this.message);
}
