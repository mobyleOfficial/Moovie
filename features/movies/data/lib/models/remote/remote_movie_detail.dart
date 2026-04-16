import 'package:movies_domain/domain.dart';

class RemoteMovieDetail {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final String tagline;
  final int? runtime;
  final List<String> genres;

  const RemoteMovieDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.tagline,
    required this.runtime,
    required this.genres,
  });

  factory RemoteMovieDetail.fromJson(Map<String, dynamic> json) =>
      RemoteMovieDetail(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String? ?? '',
        backdropPath: json['backdrop_path'] as String? ?? '',
        voteAverage: (json['vote_average'] as num).toDouble(),
        releaseDate: json['release_date'] as String? ?? '',
        tagline: json['tagline'] as String? ?? '',
        runtime: json['runtime'] as int?,
        genres: (json['genres'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map((genre) => genre['name'] as String)
            .toList(),
      );

  Movie toDomain() => Movie(
        id: id,
        title: title,
        overview: overview,
        posterPath: posterPath,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        releaseDate: releaseDate,
        tagline: tagline,
        runtime: runtime,
        genres: genres,
      );
}
