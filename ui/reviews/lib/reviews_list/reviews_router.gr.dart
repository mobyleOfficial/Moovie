// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'reviews_router.dart';

/// generated route for
/// [ReviewsPage]
class ReviewsRoute extends PageRouteInfo<ReviewsRouteArgs> {
  ReviewsRoute({
    int? movieId,
    String? movieTitle,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         ReviewsRoute.name,
         args: ReviewsRouteArgs(
           movieId: movieId,
           movieTitle: movieTitle,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ReviewsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewsRouteArgs>(
        orElse: () => const ReviewsRouteArgs(),
      );
      return ReviewsPage(
        key: args.key,
        movieId: args.movieId,
        movieTitle: args.movieTitle,
      );
    },
  );
}

class ReviewsRouteArgs {
  const ReviewsRouteArgs({this.movieId, this.movieTitle, this.key});

  final int? movieId;
  final String? movieTitle;
  final Key? key;

  @override
  String toString() =>
      'ReviewsRouteArgs{movieId: $movieId, movieTitle: $movieTitle, key: $key}';
}
