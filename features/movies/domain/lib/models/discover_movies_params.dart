class DiscoverMoviesParams {
  final int page;
  final int? primaryReleaseYear;
  final String? releaseDateGte;
  final String? releaseDateLte;
  final String? sortBy;

  const DiscoverMoviesParams({
    this.page = 1,
    this.primaryReleaseYear,
    this.releaseDateGte,
    this.releaseDateLte,
    this.sortBy,
  });
}
