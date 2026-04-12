// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'watch_list_router.dart';

/// generated route for
/// [WatchListPage]
class WatchListRoute extends PageRouteInfo<WatchListRouteArgs> {
  WatchListRoute({
    Key? key,
    required String userId,
    String? userName,
    List<PageRouteInfo>? children,
  }) : super(
         WatchListRoute.name,
         args: WatchListRouteArgs(key: key, userId: userId, userName: userName),
         initialChildren: children,
       );

  static const String name = 'WatchListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<WatchListRouteArgs>();
      return WatchListPage(
        key: args.key,
        userId: args.userId,
        userName: args.userName,
      );
    },
  );
}

class WatchListRouteArgs {
  const WatchListRouteArgs({this.key, required this.userId, this.userName});

  final Key? key;

  final String userId;

  final String? userName;

  @override
  String toString() {
    return 'WatchListRouteArgs{key: $key, userId: $userId, userName: $userName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! WatchListRouteArgs) return false;
    return key == other.key &&
        userId == other.userId &&
        userName == other.userName;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode ^ userName.hashCode;
}
