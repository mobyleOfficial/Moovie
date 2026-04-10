// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'favorite_movies_router.dart';

/// generated route for
/// [FavoriteMoviesPage]
class FavoriteMoviesRoute extends PageRouteInfo<FavoriteMoviesRouteArgs> {
  FavoriteMoviesRoute({
    Key? key,
    required String userId,
    String? userName,
    List<PageRouteInfo>? children,
  }) : super(
         FavoriteMoviesRoute.name,
         args: FavoriteMoviesRouteArgs(
           key: key,
           userId: userId,
           userName: userName,
         ),
         initialChildren: children,
       );

  static const String name = 'FavoriteMoviesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FavoriteMoviesRouteArgs>();
      return FavoriteMoviesPage(
        key: args.key,
        userId: args.userId,
        userName: args.userName,
      );
    },
  );
}

class FavoriteMoviesRouteArgs {
  const FavoriteMoviesRouteArgs({
    this.key,
    required this.userId,
    this.userName,
  });

  final Key? key;

  final String userId;

  final String? userName;

  @override
  String toString() {
    return 'FavoriteMoviesRouteArgs{key: $key, userId: $userId, userName: $userName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FavoriteMoviesRouteArgs) return false;
    return key == other.key &&
        userId == other.userId &&
        userName == other.userName;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode ^ userName.hashCode;
}
