import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movie_review/movie_review_page.dart';

part 'movie_review_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib'])
class MovieReviewRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MovieReviewRoute.page),
      ];
}
