import 'package:auto_route/auto_route.dart';
import 'package:user_activity/new_user_activity_page.dart';

part 'new_user_activity_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class NewUserActivityRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: NewUserActivityRoute.page),
      ];
}