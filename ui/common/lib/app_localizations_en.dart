// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Moovie';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get profile => 'Profile';

  @override
  String get moviesTab => 'Movies';

  @override
  String get reviewsTab => 'Reviews';

  @override
  String get unknownError => 'Unknown error';

  @override
  String movieRelease(String date) {
    return 'Release: $date';
  }

  @override
  String movieRating(String rating) {
    return 'Rating: $rating';
  }

  @override
  String movieRuntime(int minutes) {
    return 'Runtime: $minutes min';
  }

  @override
  String movieGenres(String genres) {
    return 'Genres: $genres';
  }
}
