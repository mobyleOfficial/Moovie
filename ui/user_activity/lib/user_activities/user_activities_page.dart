import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:user_activity/user_activities/user_activities_screen.dart';

@RoutePage()
class UserActivitiesPage extends StatelessWidget {
  final String userId;
  final String? userName;

  const UserActivitiesPage({
    super.key,
    required this.userId,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final activityLabel = l10n?.profileRecentActivity ?? 'Recent Activity';
    final title = userName != null
        ? '$userName — $activityLabel'
        : activityLabel;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: UserActivitiesScreen(userId: userId),
    );
  }
}
