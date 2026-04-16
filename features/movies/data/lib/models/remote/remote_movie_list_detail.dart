import 'package:movies_domain/domain.dart';

import 'package:movies_data/models/remote/remote_movie.dart';

class RemoteMovieListDetail {
  final int id;
  final String name;
  final String creator;
  final String description;
  final List<RemoteMovie> movies;
  final int totalMovies;
  final int totalPages;
  final int commentsCount;
  final int likesCount;
  final bool isLiked;
  final List<String> tags;

  const RemoteMovieListDetail({
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

  MovieList toDomain() => MovieList(
        id: id,
        name: name,
        creator: creator,
        description: description,
        movieCount: totalMovies,
        posterPaths: movies.map((movie) => movie.posterPath).toList(),
        movies: movies.map((movie) => movie.toDomain()).toList(),
        totalMovies: totalMovies,
        totalPages: totalPages,
        commentsCount: commentsCount,
        likesCount: likesCount,
        isLiked: isLiked,
        tags: tags,
      );
}