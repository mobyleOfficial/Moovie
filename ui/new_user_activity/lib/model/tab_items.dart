import 'package:movies/movies.dart';

sealed class ActivityItem {
  const ActivityItem();
}

class SectionHeader extends ActivityItem {
  final String label;
  const SectionHeader(this.label);
}

class DraftItem extends ActivityItem {
  final String title;
  final String subtitle;
  final MovieReviewDraft draft;
  const DraftItem({
    required this.title,
    required this.subtitle,
    required this.draft,
  });
}

class SearchItem extends ActivityItem {
  final String query;
  final String time;
  const SearchItem({required this.query, required this.time});
}
