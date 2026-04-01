import 'movie.dart';

class TrendingMovieListing {
  final int totalPages;
  final int totalResults;
  final List<Movie> movies;

  const TrendingMovieListing({
    required this.totalPages,
    required this.totalResults,
    required this.movies,
  });
}