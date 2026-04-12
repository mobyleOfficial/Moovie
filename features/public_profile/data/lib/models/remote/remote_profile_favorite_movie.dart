import 'package:public_profile_domain/models/profile_favorite_movie.dart';

class RemoteProfileFavoriteMovie {
  final int id;
  final String title;

  const RemoteProfileFavoriteMovie({
    required this.id,
    required this.title,
  });

  factory RemoteProfileFavoriteMovie.fromJson(Map<String, dynamic> json) =>
      RemoteProfileFavoriteMovie(
        id: json['id'] as int,
        title: json['title'] as String? ?? '',
      );

  ProfileFavoriteMovie toDomain() => ProfileFavoriteMovie(
        id: id,
        title: title,
      );
}
