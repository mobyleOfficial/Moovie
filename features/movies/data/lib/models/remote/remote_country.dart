import 'package:movies_domain/models/country.dart';

class RemoteCountry {
  final String iso;
  final String englishName;

  const RemoteCountry({required this.iso, required this.englishName});

  factory RemoteCountry.fromJson(Map<String, dynamic> json) => RemoteCountry(
        iso: json['iso_3166_1'] as String,
        englishName: json['english_name'] as String,
      );

  Country toDomain() => Country(iso: iso, englishName: englishName);
}
