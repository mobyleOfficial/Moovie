import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';

import 'movies_list_page.dart';

part 'movies_list_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class MoviesListRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MoviesListRoute.page),
      ];
}
