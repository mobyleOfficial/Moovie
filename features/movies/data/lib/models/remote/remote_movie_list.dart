import 'package:movies_domain/domain.dart';

class RemoteMovieList {
  final int id;
  final String name;
  final String creator;
  final String description;
  final int movieCount;
  final List<String> posterPaths;

  const RemoteMovieList({
    required this.id,
    required this.name,
    required this.creator,
    required this.description,
    required this.movieCount,
    required this.posterPaths,
  });

  factory RemoteMovieList.fromJson(Map<String, dynamic> json) =>
      RemoteMovieList(
        id: json['id'] as int,
        name: json['name'] as String,
        creator: json['creator'] as String,
        description: json['description'] as String,
        movieCount: json['movie_count'] as int,
        posterPaths: (json['poster_paths'] as List<dynamic>).cast<String>(),
      );

  MovieList toDomain() => MovieList(
        id: id,
        name: name,
        creator: creator,
        description: description,
        movieCount: movieCount,
        posterPaths: posterPaths,
      );
}