import 'package:user_activities_data/models/remote/remote_user_activity.dart';
import 'package:user_activities_domain/models/user_activity_listing.dart';

class RemoteUserActivityListing {
  final int totalPages;
  final int totalResults;
  final List<RemoteUserActivity> activities;

  const RemoteUserActivityListing({
    required this.totalPages,
    required this.totalResults,
    required this.activities,
  });

  factory RemoteUserActivityListing.fromJson(Map<String, dynamic> json) =>
      RemoteUserActivityListing(
        totalPages: json['total_pages'] as int,
        totalResults: json['total_results'] as int,
        activities: (json['results'] as List<dynamic>)
            .cast<Map<String, dynamic>>()
            .map(RemoteUserActivity.fromJson)
            .toList(),
      );

  UserActivityListing toDomain() => UserActivityListing(
        totalPages: totalPages,
        totalResults: totalResults,
        activities: activities.map((activity) => activity.toDomain()).toList(),
      );
}
