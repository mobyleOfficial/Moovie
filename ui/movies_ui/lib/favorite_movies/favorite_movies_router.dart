import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies_ui/favorite_movies/favorite_movies_page.dart';

part 'favorite_movies_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/favorite_movies'])
class FavoriteMoviesRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: FavoriteMoviesRoute.page),
      ];
}
