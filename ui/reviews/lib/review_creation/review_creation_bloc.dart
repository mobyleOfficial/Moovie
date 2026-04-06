import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:reviews/review_creation/review_creation_state.dart';

class ReviewCreationCubit extends Cubit<ReviewCreationState> {
  final UpsertMovieReview _upsertMovieReview;
  final int movieId;
  final String movieTitle;
  final String posterPath;
  final MovieReviewDraft? initialDraft;

  late String _currentReviewTitle;

  ReviewCreationCubit({
    required UpsertMovieReview upsertMovieReview,
    required this.movieId,
    required this.movieTitle,
    required this.posterPath,
    this.initialDraft,
  })  : _upsertMovieReview = upsertMovieReview,
        _currentReviewTitle = initialDraft?.reviewTitle ?? '',
        super(const ReviewCreationLoading()) {
    _load();
  }

  void _load() {
    final draft = initialDraft;
    if (draft != null) {
      emit(ReviewCreationReady(
        reviewTitle: draft.reviewTitle,
        rating: draft.rating,
        isFavorite: draft.isFavorite,
        isRewatch: draft.isRewatch,
        selectedTags: draft.tags.toSet(),
      ));
    } else {
      emit(const ReviewCreationReady());
    }
  }

  void updateRating(double rating) {
    final currentState = state;
    if (currentState is ReviewCreationReady) {
      final updated = currentState.copyWith(rating: rating);
      emit(updated);
      _saveDraft(updated);
    }
  }

  void toggleFavorite() {
    final currentState = state;
    if (currentState is ReviewCreationReady) {
      final updated = currentState.copyWith(isFavorite: !currentState.isFavorite);
      emit(updated);
      _saveDraft(updated);
    }
  }

  void toggleRewatch() {
    final currentState = state;
    if (currentState is ReviewCreationReady) {
      final updated = currentState.copyWith(isRewatch: !currentState.isRewatch);
      emit(updated);
      _saveDraft(updated);
    }
  }

  void toggleTag(String tag) {
    final currentState = state;
    if (currentState is ReviewCreationReady) {
      final updatedTags = Set<String>.from(currentState.selectedTags);
      if (updatedTags.contains(tag)) {
        updatedTags.remove(tag);
      } else {
        updatedTags.add(tag);
      }
      final updated = currentState.copyWith(selectedTags: updatedTags);
      emit(updated);
      _saveDraft(updated);
    }
  }

  void updateReviewTitle(String title) {
    final currentState = state;
    if (currentState is ReviewCreationReady) {
      _currentReviewTitle = title;
      _saveDraft(currentState);
    }
  }

  void _saveDraft(ReviewCreationReady reviewState) {
    final draft = MovieReviewDraft(
      id: 0,
      movieId: movieId,
      movieTitle: movieTitle,
      posterPath: posterPath,
      reviewTitle: _currentReviewTitle,
      rating: reviewState.rating,
      isFavorite: reviewState.isFavorite,
      isRewatch: reviewState.isRewatch,
      tags: reviewState.selectedTags.toList(),
      status: MovieReviewStatus.draft,
      updatedAt: DateTime.now(),
    );

    _upsertMovieReview(UpsertMovieReviewParams(
      draft: draft,
      status: MovieReviewStatus.draft,
    ));
  }
}
