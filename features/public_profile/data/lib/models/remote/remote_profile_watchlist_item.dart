import 'package:public_profile_domain/models/profile_watchlist_item.dart';

class RemoteProfileWatchlistItem {
  final int id;
  final String title;

  const RemoteProfileWatchlistItem({
    required this.id,
    required this.title,
  });

  factory RemoteProfileWatchlistItem.fromJson(Map<String, dynamic> json) =>
      RemoteProfileWatchlistItem(
        id: json['id'] as int,
        title: json['title'] as String? ?? '',
      );

  ProfileWatchlistItem toDomain() => ProfileWatchlistItem(
        id: id,
        title: title,
      );
}
