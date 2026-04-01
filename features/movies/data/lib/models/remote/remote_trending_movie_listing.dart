import 'package:movies_domain/domain.dart';

import 'remote_movie.dart';

class RemoteTrendingMovieListing {
  final int totalPages;
  final int totalResults;
  final List<RemoteMovie> movies;

  const RemoteTrendingMovieListing({
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });

  factory RemoteTrendingMovieListing.fromJson(Map<String, dynamic> json) =>
      RemoteTrendingMovieListing(
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
        movies: (json['results'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(RemoteMovie.fromJson)
            .toList(),
      );

  TrendingMovieListing toDomain() => TrendingMovieListing(
        totalPages: totalPages,
        totalResults: totalResults,
        movies: movies.map((movie) => movie.toDomain()).toList(),
      );
}