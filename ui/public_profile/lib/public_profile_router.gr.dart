// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'public_profile_router.dart';

class PublicProfileRouteArgs {
  const PublicProfileRouteArgs({this.key, required this.userId});

  final Key? key;
  final String userId;
}

/// generated route for
/// [PublicProfilePage]
class PublicProfileRoute extends PageRouteInfo<PublicProfileRouteArgs> {
  PublicProfileRoute({
    required String userId,
    Key? key,
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
