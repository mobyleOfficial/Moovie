import 'package:movies_domain/domain.dart';

class RemoteMovieReview {
  final String reviewId;
  final int movieId;
  final String title;
  final String date;
  final double rating;
  final String? author;
  final String? authorId;
  final String? content;
  final int likeCount;
  final bool likedByMe;
  final int commentCount;

  const RemoteMovieReview({
    required this.reviewId,
    required this.movieId,
    required this.title,
    required this.date,
    required this.rating,
    this.author,
    this.authorId,
    this.content,
    this.likeCount = 0,
    this.likedByMe = false,
    this.commentCount = 0,
  });

  factory RemoteMovieReview.fromJson(Map<String, dynamic> json) =>
      RemoteMovieReview(
        reviewId: (json['id'] ?? json['review_id']) as String,
        movieId: (json['movieId'] ?? json['movie_id'] ?? 0) as int,
        title: (json['title'] ?? json['movie_title']) as String,
        date: (json['date'] ?? json['review_date']) as String? ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        author: json['author'] as String?,
        authorId: (json['authorId'] ?? json['author_id']) as String?,
        content: json['content'] as String?,
        likeCount: ((json['likeCount'] ?? json['like_count']) as int?) ?? 0,
        likedByMe:
            ((json['likedByMe'] ?? json['liked_by_me']) as bool?) ?? false,
        commentCount:
            ((json['commentCount'] ?? json['comment_count']) as int?) ?? 0,
      );

  RemoteMovieReview copyWith({
    String? reviewId,
    int? movieId,
    String? title,
    String? date,
    double? rating,
    String? author,
    String? authorId,
    String? content,
    int? likeCount,
    bool? likedByMe,
    int? commentCount,
  }) =>
      RemoteMovieReview(
        reviewId: reviewId ?? this.reviewId,
        movieId: movieId ?? this.movieId,
        title: title ?? this.title,
        date: date ?? this.date,
        rating: rating ?? this.rating,
        author: author ?? this.author,
        authorId: authorId ?? this.authorId,
        content: content ?? this.content,
        likeCount: likeCount ?? this.likeCount,
        likedByMe: likedByMe ?? this.likedByMe,
        commentCount: commentCount ?? this.commentCount,
      );

  MovieReview toDomain() => MovieReview(
        id: reviewId,
        movieId: movieId,
        title: title,
        date: date,
        rating: rating,
        author: author,
        authorId: authorId,
        content: content,
        likeCount: likeCount,
        likedByCurrentUser: likedByMe,
        commentCount: commentCount,
      );
}
