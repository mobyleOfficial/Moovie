import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';

import 'package:profile_ui/profile_page.dart';

part 'profile_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class ProfileRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ProfileRoute.page),
      ];
}