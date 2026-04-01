import 'package:auto_route/auto_route.dart';
import 'package:home/home_router.dart';
import 'package:moovie/routes/main_screen.dart';
import 'package:movies_list/movies_list_router.dart';
import 'package:reviews/reviews_router.dart';
import 'package:search/search_router.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(
              page: HomeTab.page,
              children: [
                AutoRoute(
                  page: HomeRoute.page,
                  initial: true,
                  children: [
                    AutoRoute(page: MoviesListRoute.page, initial: true),
                    AutoRoute(page: ReviewsRoute.page),
                  ],
                ),
              ],
            ),
            AutoRoute(
              page: SearchTab.page,
              children: [
                AutoRoute(page: SearchRoute.page, initial: true),
              ],
            ),
          ],
        ),
      ];
}

@RoutePage(name: 'HomeTab')
class HomeTabPage extends AutoRouter {
  const HomeTabPage({super.key});
}

@RoutePage(name: 'SearchTab')
class SearchTabPage extends AutoRouter {
  const SearchTabPage({super.key});
}