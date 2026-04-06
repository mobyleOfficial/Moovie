class RecentSearch {
  final int id;
  final String query;
  final DateTime searchedAt;

  const RecentSearch({
    required this.id,
    required this.query,
    required this.searchedAt,
  });
}
