// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'movies_list_router.dart';

/// generated route for
/// [MoviesListPage]
class MoviesListRoute extends PageRouteInfo<void> {
  const MoviesListRoute({List<PageRouteInfo>? children})
    : super(MoviesListRoute.name, initialChildren: children);

  static const String name = 'MoviesListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return MoviesListPage(
        getTrendingMovies: GetIt.instance<GetTrendingMovies>(),
      );
    },
  );
}
