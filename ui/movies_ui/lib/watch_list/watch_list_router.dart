import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies_ui/watch_list/watch_list_page.dart';

part 'watch_list_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/watch_list'])
class WatchListRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: WatchListRoute.page),
      ];
}
