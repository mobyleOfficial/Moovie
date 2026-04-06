import 'package:movies_domain/models/movie_review_status.dart';

class MovieReviewDraft {
  final int id;
  final int movieId;
  final String movieTitle;
  final String posterPath;
  final String reviewTitle;
  final double rating;
  final bool isFavorite;
  final bool isRewatch;
  final List<String> tags;
  final MovieReviewStatus status;
  final DateTime updatedAt;

  const MovieReviewDraft({
    required this.id,
    required this.movieId,
    required this.movieTitle,
    required this.posterPath,
    required this.reviewTitle,
    required this.rating,
    required this.isFavorite,
    required this.isRewatch,
    required this.tags,
    required this.status,
    required this.updatedAt,
  });
}
