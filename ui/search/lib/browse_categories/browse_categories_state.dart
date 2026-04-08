import 'package:movies/movies.dart';

sealed class BrowseCategoriesState {
  const BrowseCategoriesState();
}

class BrowseCategoriesLoading extends BrowseCategoriesState {
  const BrowseCategoriesLoading();
}

class BrowseCategoriesSuccess extends BrowseCategoriesState {
  final List<Genre> genres;
  final List<Country> countries;
  final List<Language> languages;

  const BrowseCategoriesSuccess({
    required this.genres,
    required this.countries,
    required this.languages,
  });
}

class BrowseCategoriesError extends BrowseCategoriesState {
  final String message;

  const BrowseCategoriesError(this.message);
}
