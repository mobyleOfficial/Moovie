import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_page.dart';

part 'movie_list_detail_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/movie_list_detail'])
class MovieListDetailRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: MovieListDetailRoute.page),
      ];
}