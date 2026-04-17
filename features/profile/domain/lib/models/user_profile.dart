import 'package:movies_domain/models/movie.dart';
import 'package:profile_domain/models/user_summary.dart';

class UserProfile {
  final String photoUrl;
  final String username;
  final String bio;
  final List<Movie> moviesWatched;
  final List<UserSummary> following;
  final List<UserSummary> followers;

  const UserProfile({
    required this.photoUrl,
    required this.username,
    required this.bio,
    this.moviesWatched = const [],
    this.following = const [],
    this.followers = const [],
  });

  UserProfile copyWith({
    String? photoUrl,
    String? username,
    String? bio,
    List<Movie>? moviesWatched,
    List<UserSummary>? following,
    List<UserSummary>? followers,
  }) =>
      UserProfile(
        photoUrl: photoUrl ?? this.photoUrl,
        username: username ?? this.username,
        bio: bio ?? this.bio,
        moviesWatched: moviesWatched ?? this.moviesWatched,
        following: following ?? this.following,
        followers: followers ?? this.followers,
      );
}
