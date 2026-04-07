import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'search_page.dart';

part 'search_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class SearchRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SearchRoute.page),
      ];
}