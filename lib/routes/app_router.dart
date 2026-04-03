import 'package:social/social_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:home/home_router.dart';
import 'package:moovie/routes/main_screen.dart';
import 'package:movie_detail/movie_detail_router.dart';
import 'package:movies_list/movies_list_router.dart';
import 'package:new_user_activity/new_user_activity_router.dart';
import 'package:profile_ui/profile_router.dart';
import 'package:public_profile/public_profile_router.dart';
import 'package:reviews/reviews_list/reviews_router.dart';
import 'package:search/search_router.dart';

part 'app_router.gr.dart';

const _animationDuration = Duration(milliseconds: 300);

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
            AutoRoute(
              page: SocialTab.page,
              children: [
                AutoRoute(page: SocialRoute.page, initial: true),
                AutoRoute(page: PublicProfileRoute.page),
              ],
            ),
            AutoRoute(
              page: ProfileTab.page,
              children: [
                AutoRoute(page: ProfileRoute.page, initial: true),
              ],
            ),
          ],
        ),
        AutoRoute(page: MovieDetailRoute.page),
        AutoRoute(page: PublicProfileRoute.page),
        CustomRoute(
          page: NewUserActivityRoute.page,
          transitionsBuilder: TransitionsBuilders.slideBottom,
          duration: _animationDuration,
          reverseDuration: _animationDuration,
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

@RoutePage(name: 'SocialTab')
class SocialTabPage extends AutoRouter {
  const SocialTabPage({super.key});
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({super.key});
}

