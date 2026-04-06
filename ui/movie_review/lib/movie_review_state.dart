sealed class MovieReviewState {
  const MovieReviewState();
}

class MovieReviewLoading extends MovieReviewState {
  const MovieReviewLoading();
}

class MovieReviewReady extends MovieReviewState {
  final String reviewTitle;
  final double rating;
  final bool isFavorite;
  final bool isRewatch;
  final Set<String> selectedTags;

  const MovieReviewReady({
    this.reviewTitle = '',
    this.rating = 0,
    this.isFavorite = false,
    this.isRewatch = false,
    this.selectedTags = const {},
  });

  MovieReviewReady copyWith({
    String? reviewTitle,
    double? rating,
    bool? isFavorite,
    bool? isRewatch,
    Set<String>? selectedTags,
  }) =>
      MovieReviewReady(
        reviewTitle: reviewTitle ?? this.reviewTitle,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
        isRewatch: isRewatch ?? this.isRewatch,
        selectedTags: selectedTags ?? this.selectedTags,
      );
}

class MovieReviewError extends MovieReviewState {
  final String message;

  const MovieReviewError(this.message);
}
