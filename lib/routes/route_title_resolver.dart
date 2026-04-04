import 'package:auto_route/auto_route.dart';
import 'package:public_profile/public_profile_router.dart';
import 'package:reviews/review_details/review_details_router.dart';

String? resolveRouteTitle(RouteData<dynamic> routeData) => switch (routeData.name) {
      ReviewDetailsRoute.name => routeData.argsAs<ReviewDetailsRouteArgs>().movieTitle,
      PublicProfileRoute.name => routeData.argsAs<PublicProfileRouteArgs>().userId,
      _ => null,
    };
