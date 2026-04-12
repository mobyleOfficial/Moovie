import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:user_activity/user_activities/user_activities_page.dart';

part 'user_activities_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/user_activities'])
class UserActivitiesRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: UserActivitiesRoute.page),
      ];
}
