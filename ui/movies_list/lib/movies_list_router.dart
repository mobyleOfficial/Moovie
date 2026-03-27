import 'package:auto_route/auto_route.dart';

import 'movies_list_screen.dart';

part 'movies_list_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class MoviesListRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MoviesListRoute.page),
      ];
}
