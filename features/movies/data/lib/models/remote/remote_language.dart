import 'package:movies_domain/models/language.dart';

class RemoteLanguage {
  final String iso;
  final String englishName;

  const RemoteLanguage({required this.iso, required this.englishName});

  factory RemoteLanguage.fromJson(Map<String, dynamic> json) => RemoteLanguage(
        iso: json['iso_639_1'] as String,
        englishName: json['english_name'] as String,
      );

  Language toDomain() => Language(iso: iso, englishName: englishName);
}
