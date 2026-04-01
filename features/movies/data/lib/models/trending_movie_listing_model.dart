import 'package:movies_domain/domain.dart';

import 'movie_model.dart';

class TrendingMovieListingModel {
  final int totalPages;
  final int totalResults;
  final List<MovieModel> movies;

  const TrendingMovieListingModel({
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });

  factory TrendingMovieListingModel.fromJson(Map<String, dynamic> json) =>
      TrendingMovieListingModel(
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
        movies: (json['results'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(MovieModel.fromJson)
            .toList(),
      );

  TrendingMovieListing toDomain() => TrendingMovieListing(
        totalPages: totalPages,
        totalResults: totalResults,
        movies: movies.map((movie) => movie.toDomain()).toList(),
      );
}