import 'package:auto_route/auto_route.dart';
import 'package:sign_up_ui/sign_up_page.dart';

part 'sign_up_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class SignUpRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SignUpRoute.page),
      ];
}
