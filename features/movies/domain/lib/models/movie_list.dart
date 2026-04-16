import 'package:movies_domain/models/movie.dart';

class MovieList {
  final int id;
  final String name;
  final String creator;
  final String description;
  final int movieCount;
  final List<String> posterPaths;
  final List<Movie>? movies;
  final int? totalMovies;
  final int? totalPages;
  final int? commentsCount;
  final int? likesCount;
  final bool? isLiked;
  final List<String>? tags;

  const MovieList({
    required this.id,
    required this.name,
    required this.creator,
    required this.description,
    required this.movieCount,
    required this.posterPaths,
    this.movies,
    this.totalMovies,
    this.totalPages,
    this.commentsCount,
    this.likesCount,
    this.isLiked,
    this.tags,
  });
}
