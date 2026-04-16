class UserProfile {
  final String photoUrl;
  final String username;
  final String bio;

  const UserProfile({
    required this.photoUrl,
    required this.username,
    required this.bio,
  });

  UserProfile copyWith({
    String? photoUrl,
    String? username,
    String? bio,
  }) =>
      UserProfile(
        photoUrl: photoUrl ?? this.photoUrl,
        username: username ?? this.username,
        bio: bio ?? this.bio,
      );
}
