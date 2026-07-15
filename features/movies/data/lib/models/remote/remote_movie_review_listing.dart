import 'package:movies_domain/domain.dart';

import 'package:movies_data/models/remote/remote_movie_review.dart';

class RemoteMovieReviewListing {
  final int totalPages;
  final int totalResults;
  final List<RemoteMovieReview> reviews;

  const RemoteMovieReviewListing({
    required this.totalPages,
    required this.totalResults,
    required this.reviews,
  });

  factory RemoteMovieReviewListing.fromJson(Map<String, dynamic> json) =>
      RemoteMovieReviewListing(
        totalPages: (json['totalPages'] ?? json['total_pages']) as int,
        totalResults: (json['totalResults'] ?? json['total_results']) as int,
        reviews: ((json['reviews'] ?? json['results']) as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(RemoteMovieReview.fromJson)
            .toList(),
      );

  MovieReviewListing toDomain() => MovieReviewListing(
        totalPages: totalPages,
        totalResults: totalResults,
        reviews: reviews.map((review) => review.toDomain()).toList(),
      );
}
