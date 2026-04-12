import 'package:user_activities_domain/models/user_activity.dart';

class RemoteUserActivity {
  final String action;
  final String movie;
  final String time;

  const RemoteUserActivity({
    required this.action,
    required this.movie,
    required this.time,
  });

  factory RemoteUserActivity.fromJson(Map<String, dynamic> json) =>
      RemoteUserActivity(
        action: json['action'] as String? ?? '',
        movie: json['movie'] as String? ?? '',
        time: json['time'] as String? ?? '',
      );

  UserActivity toDomain() => UserActivity(
        action: action,
        movie: movie,
        time: time,
      );
}
