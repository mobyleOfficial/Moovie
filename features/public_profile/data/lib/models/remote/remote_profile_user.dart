import 'package:public_profile_domain/models/profile_user.dart';

class RemoteProfileUser {
  final String id;
  final String displayName;
  final String initials;

  const RemoteProfileUser({
    required this.id,
    required this.displayName,
    required this.initials,
  });

  factory RemoteProfileUser.fromJson(Map<String, dynamic> json) =>
      RemoteProfileUser(
        id: json['id'] as String,
        displayName: json['display_name'] as String? ?? '',
        initials: json['initials'] as String? ?? '',
      );

  ProfileUser toDomain() => ProfileUser(
        id: id,
        displayName: displayName,
        initials: initials,
      );
}
