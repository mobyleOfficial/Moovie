import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reviews/review_details/review_details_page.dart';

part 'review_details_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/review_details'])
class ReviewDetailsRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ReviewDetailsRoute.page),
      ];
}