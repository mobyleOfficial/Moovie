class NicknameAvailabilityModel {
  final String nickname;
  final bool available;

  const NicknameAvailabilityModel({
    required this.nickname,
    required this.available,
  });

  factory NicknameAvailabilityModel.fromJson(Map<String, dynamic> json) =>
      NicknameAvailabilityModel(
        nickname: json['nickname'] as String,
        available: json['available'] as bool,
      );
}
