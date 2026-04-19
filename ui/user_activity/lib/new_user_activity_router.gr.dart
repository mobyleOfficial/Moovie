// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'new_user_activity_router.dart';

/// generated route for
/// [NewUserActivityPage]
class NewUserActivityRoute extends PageRouteInfo<void> {
  const NewUserActivityRoute({List<PageRouteInfo>? children})
    : super(NewUserActivityRoute.name, initialChildren: children);

  static const String name = 'NewUserActivityRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const NewUserActivityPage();
    },
  );
}

/// generated route for
/// [UserActivitiesPage]
class UserActivitiesRoute extends PageRouteInfo<UserActivitiesRouteArgs> {
  UserActivitiesRoute({
    Key? key,
    required String userId,
    String? userName,
    List<PageRouteInfo>? children,
  }) : super(
         UserActivitiesRoute.name,
         args: UserActivitiesRouteArgs(
           key: key,
           userId: userId,
           userName: userName,
         ),
         initialChildren: children,
       );

  static const String name = 'UserActivitiesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<UserActivitiesRouteArgs>();
      return UserActivitiesPage(
        key: args.key,
        userId: args.userId,
        userName: args.userName,
      );
    },
  );
}

class UserActivitiesRouteArgs {
  const UserActivitiesRouteArgs({
    this.key,
    required this.userId,
    this.userName,
  });

  final Key? key;

  final String userId;

  final String? userName;

  @override
  String toString() {
    return 'UserActivitiesRouteArgs{key: $key, userId: $userId, userName: $userName}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserActivitiesRouteArgs) return false;
    return key == other.key &&
        userId == other.userId &&
        userName == other.userName;
  }

  @override
  int get hashCode => key.hashCode ^ userId.hashCode ^ userName.hashCode;
}
