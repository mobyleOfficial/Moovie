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
    Key? key,
    int? movieId,
    String? movieTitle,
    List<PageRouteInfo>? children,
  }) : super(
         ReviewsRoute.name,
         args: ReviewsRouteArgs(
           key: key,
           movieId: movieId,
           movieTitle: movieTitle,
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
  const ReviewsRouteArgs({this.key, this.movieId, this.movieTitle});

  final Key? key;

  final int? movieId;

  final String? movieTitle;

  @override
  String toString() {
    return 'ReviewsRouteArgs{key: $key, movieId: $movieId, movieTitle: $movieTitle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReviewsRouteArgs) return false;
    return key == other.key &&
        movieId == other.movieId &&
        movieTitle == other.movieTitle;
  }

  @override
  int get hashCode => key.hashCode ^ movieId.hashCode ^ movieTitle.hashCode;
}
