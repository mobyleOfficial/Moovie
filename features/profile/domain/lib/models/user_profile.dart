import 'package:movies_domain/models/movie.dart';

class UserProfile {
  final String photoUrl;
  final String username;
  final String bio;
  final int moviesWatchedCount;
  final int followingCount;
  final int followersCount;
  final List<Movie> recentMovies;

  const UserProfile({
    required this.photoUrl,
    required this.username,
    required this.bio,
    this.moviesWatchedCount = 0,
    this.followingCount = 0,
    this.followersCount = 0,
    this.recentMovies = const [],
  });

  UserProfile copyWith({
    String? photoUrl,
    String? username,
    String? bio,
    int? moviesWatchedCount,
    int? followingCount,
    int? followersCount,
    List<Movie>? recentMovies,
  }) =>
      UserProfile(
        photoUrl: photoUrl ?? this.photoUrl,
        username: username ?? this.username,
        bio: bio ?? this.bio,
        moviesWatchedCount: moviesWatchedCount ?? this.moviesWatchedCount,
        followingCount: followingCount ?? this.followingCount,
        followersCount: followersCount ?? this.followersCount,
        recentMovies: recentMovies ?? this.recentMovies,
      );
}
