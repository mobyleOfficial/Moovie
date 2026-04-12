import 'package:public_profile_domain/models/profile_recent_activity.dart';

class RemoteProfileRecentActivity {
  final String action;
  final String movie;
  final String time;

  const RemoteProfileRecentActivity({
    required this.action,
    required this.movie,
    required this.time,
  });

  factory RemoteProfileRecentActivity.fromJson(Map<String, dynamic> json) =>
      RemoteProfileRecentActivity(
        action: json['action'] as String? ?? '',
        movie: json['movie'] as String? ?? '',
        time: json['time'] as String? ?? '',
      );

  ProfileRecentActivity toDomain() => ProfileRecentActivity(
        action: action,
        movie: movie,
        time: time,
      );
}
