import 'package:public_profile_data/models/remote/remote_profile_favorite_movie.dart';
import 'package:public_profile_data/models/remote/remote_profile_recent_activity.dart';
import 'package:public_profile_data/models/remote/remote_profile_watchlist_item.dart';
import 'package:public_profile_domain/models/public_profile.dart';

class RemotePublicProfile {
  final String id;
  final String displayName;
  final String initials;
  final String bio;
  final int moviesWatched;
  final int following;
  final int followers;
  final List<RemoteProfileFavoriteMovie> favoriteMovies;
  final List<RemoteProfileRecentActivity> recentActivities;
  final List<RemoteProfileWatchlistItem> watchlist;

  const RemotePublicProfile({
    required this.id,
    required this.displayName,
    required this.initials,
    required this.bio,
    required this.moviesWatched,
    required this.following,
    required this.followers,
    required this.favoriteMovies,
    required this.recentActivities,
    required this.watchlist,
  });

  factory RemotePublicProfile.fromJson(Map<String, dynamic> json) =>
      RemotePublicProfile(
        id: json['id'] as String,
        displayName: json['display_name'] as String? ?? '',
        initials: json['initials'] as String? ?? '',
        bio: json['bio'] as String? ?? '',
        moviesWatched: json['movies_watched'] as int? ?? 0,
        following: json['following'] as int? ?? 0,
        followers: json['followers'] as int? ?? 0,
        favoriteMovies: (json['favorite_movies'] as List<dynamic>?)
                ?.cast<Map<String, dynamic>>()
                .map(RemoteProfileFavoriteMovie.fromJson)
                .toList() ??
            [],
        recentActivities: (json['recent_activities'] as List<dynamic>?)
                ?.cast<Map<String, dynamic>>()
                .map(RemoteProfileRecentActivity.fromJson)
                .toList() ??
            [],
        watchlist: (json['watchlist'] as List<dynamic>?)
                ?.cast<Map<String, dynamic>>()
                .map(RemoteProfileWatchlistItem.fromJson)
                .toList() ??
            [],
      );

  PublicProfile toDomain() => PublicProfile(
        id: id,
        displayName: displayName,
        initials: initials,
        bio: bio,
        moviesWatched: moviesWatched,
        following: following,
        followers: followers,
        favoriteMovies:
            favoriteMovies.map((movie) => movie.toDomain()).toList(),
        recentActivities:
            recentActivities.map((activity) => activity.toDomain()).toList(),
        watchlist: watchlist.map((item) => item.toDomain()).toList(),
      );
}
