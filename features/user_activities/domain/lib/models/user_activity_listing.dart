import 'package:user_activities_domain/models/user_activity.dart';

class UserActivityListing {
  final int totalPages;
  final int totalResults;
  final List<UserActivity> activities;

  const UserActivityListing({
    required this.totalPages,
    required this.totalResults,
    required this.activities,
  });
}
