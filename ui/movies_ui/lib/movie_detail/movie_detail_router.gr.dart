// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'movie_detail_router.dart';

/// generated route for
/// [MovieDetailPage]
class MovieDetailRoute extends PageRouteInfo<MovieDetailRouteArgs> {
  MovieDetailRoute({
    Key? key,
    required int movieId,
    required String movieTitle,
    List<PageRouteInfo>? children,
  }) : super(
         MovieDetailRoute.name,
         args: MovieDetailRouteArgs(
           key: key,
           movieId: movieId,
           movieTitle: movieTitle,
         ),
         initialChildren: children,
       );

  static const String name = 'MovieDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailRouteArgs>();
      return MovieDetailPage(
        key: args.key,
        movieId: args.movieId,
        movieTitle: args.movieTitle,
      );
    },
  );
}

class MovieDetailRouteArgs {
  const MovieDetailRouteArgs({
    this.key,
    required this.movieId,
    required this.movieTitle,
  });

  final Key? key;

  final int movieId;

  final String movieTitle;

  @override
  String toString() {
    return 'MovieDetailRouteArgs{key: $key, movieId: $movieId, movieTitle: $movieTitle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieDetailRouteArgs) return false;
    return key == other.key &&
        movieId == other.movieId &&
        movieTitle == other.movieTitle;
  }

  @override
  int get hashCode => key.hashCode ^ movieId.hashCode ^ movieTitle.hashCode;
}
