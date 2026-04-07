import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:reviews/review_creation/review_creation_page.dart';

part 'review_creation_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/review_creation'])
class ReviewCreationRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: ReviewCreationRoute.page),
      ];
}