import 'package:public_profile_domain/models/profile_favorite_movie.dart';
import 'package:public_profile_domain/models/profile_recent_activity.dart';
import 'package:public_profile_domain/models/profile_watchlist_item.dart';

class PublicProfile {
  final String id;
  final String displayName;
  final String initials;
  final String bio;
  final int moviesWatched;
  final int following;
  final int followers;
  final List<ProfileFavoriteMovie> favoriteMovies;
  final List<ProfileRecentActivity> recentActivities;
  final List<ProfileWatchlistItem> watchlist;

  const PublicProfile({
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
}
