import 'package:auto_route/auto_route.dart';
import 'package:movies_list/movies_list_router.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MoviesListRoute.page,
          initial: true,
        ),
      ];
}
