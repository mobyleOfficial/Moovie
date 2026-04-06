sealed class ReviewCreationState {
  const ReviewCreationState();
}

class ReviewCreationLoading extends ReviewCreationState {
  const ReviewCreationLoading();
}

class ReviewCreationReady extends ReviewCreationState {
  final String reviewTitle;
  final double rating;
  final bool isFavorite;
  final bool isRewatch;
  final Set<String> selectedTags;

  const ReviewCreationReady({
    this.reviewTitle = '',
    this.rating = 0,
    this.isFavorite = false,
    this.isRewatch = false,
    this.selectedTags = const {},
  });

  ReviewCreationReady copyWith({
    String? reviewTitle,
    double? rating,
    bool? isFavorite,
    bool? isRewatch,
    Set<String>? selectedTags,
  }) =>
      ReviewCreationReady(
        reviewTitle: reviewTitle ?? this.reviewTitle,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
        isRewatch: isRewatch ?? this.isRewatch,
        selectedTags: selectedTags ?? this.selectedTags,
      );
}

class ReviewCreationError extends ReviewCreationState {
  final String message;

  const ReviewCreationError(this.message);
}
