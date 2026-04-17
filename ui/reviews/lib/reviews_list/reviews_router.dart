import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' show Key;

import 'package:reviews/reviews_list/reviews_page.dart';

part 'reviews_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/reviews_list'])
class ReviewsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ReviewsRoute.page),
      ];
}