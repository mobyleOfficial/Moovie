import 'package:public_profile_domain/models/profile_watched_movie.dart';

class RemoteProfileWatchedMovie {
  final int id;
  final String title;
  final String posterPath;

  const RemoteProfileWatchedMovie({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory RemoteProfileWatchedMovie.fromJson(Map<String, dynamic> json) =>
      RemoteProfileWatchedMovie(
        id: json['id'] as int,
        title: json['title'] as String? ?? '',
        posterPath: json['poster_path'] as String? ?? '',
      );

  ProfileWatchedMovie toDomain() => ProfileWatchedMovie(
        id: id,
        title: title,
        posterPath: posterPath,
      );
}
