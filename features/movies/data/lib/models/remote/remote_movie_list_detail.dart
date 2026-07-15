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

  factory RemoteMovieListDetail.fromJson(Map<String, dynamic> json) =>
      RemoteMovieListDetail(
        id: json['id'] as int,
        name: json['name'] as String,
        creator: json['creator'] as String,
        description: (json['description'] as String?) ?? '',
        movies: ((json['movies'] as List<dynamic>?) ?? [])
            .cast<Map<String, dynamic>>()
            .map(RemoteMovie.fromJson)
            .toList(),
        totalMovies: (json['totalMovies'] as int?) ?? 0,
        totalPages: (json['totalPages'] as int?) ?? 0,
        commentsCount: (json['commentsCount'] as int?) ?? 0,
        likesCount: (json['likesCount'] as int?) ?? 0,
        isLiked: (json['isLiked'] as bool?) ?? false,
        tags: ((json['tags'] as List<dynamic>?) ?? []).cast<String>(),
      );

  MovieList toDomain() => MovieList(
        id: id,
        name: name,
        creator: creator,
        description: description,
        movies: movies.map((movie) => movie.toDomain()).toList(),
        info: MovieListInfo(
          movieCount: totalMovies,
          posterPaths: movies.map((movie) => movie.posterPath).toList(),
          totalMovies: totalMovies,
          totalPages: totalPages,
          commentsCount: commentsCount,
          likesCount: likesCount,
          isLiked: isLiked,
          tags: tags,
        ),
      );
}
