// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'review_creation_router.dart';

/// generated route for
/// [ReviewCreationPage]
class ReviewCreationRoute extends PageRouteInfo<ReviewCreationRouteArgs> {
  ReviewCreationRoute({
    Key? key,
    required int movieId,
    required String movieTitle,
    required String posterPath,
    MovieReviewDraft? initialDraft,
    List<PageRouteInfo>? children,
  }) : super(
         ReviewCreationRoute.name,
         args: ReviewCreationRouteArgs(
           key: key,
           movieId: movieId,
           movieTitle: movieTitle,
           posterPath: posterPath,
           initialDraft: initialDraft,
         ),
         initialChildren: children,
       );

  static const String name = 'ReviewCreationRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReviewCreationRouteArgs>();
      return ReviewCreationPage(
        key: args.key,
        movieId: args.movieId,
        movieTitle: args.movieTitle,
        posterPath: args.posterPath,
        initialDraft: args.initialDraft,
      );
    },
  );
}

class ReviewCreationRouteArgs {
  const ReviewCreationRouteArgs({
    this.key,
    required this.movieId,
    required this.movieTitle,
    required this.posterPath,
    this.initialDraft,
  });

  final Key? key;

  final int movieId;

  final String movieTitle;

  final String posterPath;

  final MovieReviewDraft? initialDraft;

  @override
  String toString() {
    return 'ReviewCreationRouteArgs{key: $key, movieId: $movieId, movieTitle: $movieTitle, posterPath: $posterPath, initialDraft: $initialDraft}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReviewCreationRouteArgs) return false;
    return key == other.key &&
        movieId == other.movieId &&
        movieTitle == other.movieTitle &&
        posterPath == other.posterPath &&
        initialDraft == other.initialDraft;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      movieId.hashCode ^
      movieTitle.hashCode ^
      posterPath.hashCode ^
      initialDraft.hashCode;
}
