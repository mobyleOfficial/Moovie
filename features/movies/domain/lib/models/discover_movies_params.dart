class DiscoverMoviesParams {
  final int page;
  final int? primaryReleaseYear;
  final String? releaseDateGte;
  final String? releaseDateLte;
  final String? sortBy;
  final String? withGenres;
  final String? withOriginalLanguage;
  final String? withOriginCountry;
  final int? voteCountGte;

  const DiscoverMoviesParams({
    this.page = 1,
    this.primaryReleaseYear,
    this.releaseDateGte,
    this.releaseDateLte,
    this.sortBy,
    this.withGenres,
    this.withOriginalLanguage,
    this.withOriginCountry,
    this.voteCountGte,
  });
}
