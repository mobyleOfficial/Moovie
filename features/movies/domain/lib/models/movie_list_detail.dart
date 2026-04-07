import 'package:movies_domain/models/movie.dart';

class MovieListDetail {
  final int id;
  final String name;
  final String creator;
  final String description;
  final List<Movie> movies;
  final int totalMovies;
  final int totalPages;
  final int commentsCount;
  final int likesCount;
  final bool isLiked;
  final List<String> tags;

  const MovieListDetail({
    required this.id,
    required this.name,
    required this.creator,
    required this.description,
    required this.movies,
    required this.totalMovies,
    required this.totalPages,
    required this.commentsCount,
    required this.likesCount,
    required this.isLiked,
    required this.tags,
  });
}