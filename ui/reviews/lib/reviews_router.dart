import 'package:auto_route/auto_route.dart';

import 'reviews_screen.dart';

part 'reviews_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class ReviewsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ReviewsRoute.page),
      ];
}