import 'package:movies_domain/domain.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class LocalMovieReviewDraft {
  @Id()
  int id;
  @Unique()
  int movieId;
  String movieTitle;
  String posterPath;
  String reviewTitle;
  double rating;
  bool isFavorite;
  bool isRewatch;
  String tagsJson;
  int statusIndex;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  LocalMovieReviewDraft({
    this.id = 0,
    required this.movieId,
    required this.movieTitle,
    required this.posterPath,
    required this.reviewTitle,
    required this.rating,
    required this.isFavorite,
    required this.isRewatch,
    required this.tagsJson,
    required this.statusIndex,
    required this.updatedAt,
  });

  factory LocalMovieReviewDraft.fromDomain(
    MovieReviewDraft draft,
    MovieReviewStatus status,
  ) =>
      LocalMovieReviewDraft(
        id: draft.id,
        movieId: draft.movieId,
        movieTitle: draft.movieTitle,
        posterPath: draft.posterPath,
        reviewTitle: draft.reviewTitle,
        rating: draft.rating,
        isFavorite: draft.isFavorite,
        isRewatch: draft.isRewatch,
        tagsJson: draft.tags.join('|'),
        statusIndex: status.index,
        updatedAt: DateTime.now(),
      );

  MovieReviewDraft toDomain() => MovieReviewDraft(
        id: id,
        movieId: movieId,
        movieTitle: movieTitle,
        posterPath: posterPath,
        reviewTitle: reviewTitle,
        rating: rating,
        isFavorite: isFavorite,
        isRewatch: isRewatch,
        tags: tagsJson.isEmpty ? [] : tagsJson.split('|'),
        status: MovieReviewStatus.values[statusIndex],
        updatedAt: updatedAt,
      );
}
