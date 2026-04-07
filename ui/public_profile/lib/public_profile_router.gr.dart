// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'public_profile_router.dart';

/// generated route for
/// [PublicProfilePage]
class PublicProfileRoute extends PageRouteInfo<PublicProfileRouteArgs> {
  PublicProfileRoute({
    Key? key,
    required String userId,
    List<PageRouteInfo>? children,
  }) : super(
         PublicProfileRoute.name,
         args: PublicProfileRouteArgs(key: key, userId: userId),
         initialChildren: children,
       );

  static const String name = 'PublicProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PublicProfileRouteArgs>();
      return PublicProfilePage(key: args.key, userId: args.userId);
    },
  );
}

class PublicProfileRouteArgs {
  const PublicProfileRouteArgs({this.key, required this.userId});

  final Key? key;

  final String userId;

  @override
  String toString() {
    return 'PublicProfileRouteArgs{key: $key, userId: $userId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PublicProfileRouteArgs) return false;
    return key == other.key && userId == other.userId;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode;
}
