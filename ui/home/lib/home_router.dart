import 'package:auto_route/auto_route.dart';

import 'home_page.dart';

part 'home_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class HomeRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page),
      ];
}