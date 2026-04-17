// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'profile_router.dart';

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    Key? key,
    required String initialPhotoUrl,
    required String initialUsername,
    required String initialBio,
    List<PageRouteInfo>? children,
  }) : super(
         EditProfileRoute.name,
         args: EditProfileRouteArgs(
           key: key,
           initialPhotoUrl: initialPhotoUrl,
           initialUsername: initialUsername,
           initialBio: initialBio,
         ),
         initialChildren: children,
       );

  static const String name = 'EditProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return EditProfilePage(
        key: args.key,
        initialPhotoUrl: args.initialPhotoUrl,
        initialUsername: args.initialUsername,
        initialBio: args.initialBio,
      );
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.initialPhotoUrl,
    required this.initialUsername,
    required this.initialBio,
  });

  final Key? key;

  final String initialPhotoUrl;

  final String initialUsername;

  final String initialBio;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, initialPhotoUrl: $initialPhotoUrl, initialUsername: $initialUsername, initialBio: $initialBio}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditProfileRouteArgs) return false;
    return key == other.key &&
        initialPhotoUrl == other.initialPhotoUrl &&
        initialUsername == other.initialUsername &&
        initialBio == other.initialBio;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      initialPhotoUrl.hashCode ^
      initialUsername.hashCode ^
      initialBio.hashCode;
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfilePage();
    },
  );
}
