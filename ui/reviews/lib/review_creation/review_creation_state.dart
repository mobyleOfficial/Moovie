sealed class ReviewCreationState {
  const ReviewCreationState();
}

class ReviewCreationLoading extends ReviewCreationState {
  const ReviewCreationLoading();
}

class ReviewCreationReady extends ReviewCreationState {
  final String reviewTitle;
  final String reviewBody;
  final double rating;
  final bool isFavorite;
  final bool isRewatch;
  final Set<String> selectedTags;
  final bool showErrors;

  const ReviewCreationReady({
    this.reviewTitle = '',
    this.reviewBody = '',
    this.rating = 0,
    this.isFavorite = false,
    this.isRewatch = false,
    this.selectedTags = const {},
    this.showErrors = false,
  });

  bool get isCanSubmit =>
      reviewTitle.isNotEmpty &&
      rating > 0 &&
      reviewBody.isNotEmpty &&
      selectedTags.isNotEmpty;

  bool get hasTitleError => showErrors && reviewTitle.isEmpty;
  bool get hasRatingError => showErrors && rating == 0;
  bool get hasBodyError => showErrors && reviewBody.isEmpty;
  bool get hasTagsError => showErrors && selectedTags.isEmpty;

  ReviewCreationReady copyWith({
    String? reviewTitle,
    String? reviewBody,
    double? rating,
    bool? isFavorite,
    bool? isRewatch,
    Set<String>? selectedTags,
    bool? showErrors,
  }) =>
      ReviewCreationReady(
        reviewTitle: reviewTitle ?? this.reviewTitle,
        reviewBody: reviewBody ?? this.reviewBody,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
        isRewatch: isRewatch ?? this.isRewatch,
        selectedTags: selectedTags ?? this.selectedTags,
        showErrors: showErrors ?? this.showErrors,
      );
}

class ReviewCreationError extends ReviewCreationState {
  final String message;

  const ReviewCreationError(this.message);
}
