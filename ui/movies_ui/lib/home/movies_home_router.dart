import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/home/movies_home_page.dart';

part 'movies_home_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class MoviesHomeRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MoviesHomeRoute.page),
      ];
}
