// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Moovie';

  @override
  String get home => 'Inicio';

  @override
  String get search => 'Buscar';

  @override
  String get profile => 'Perfil';

  @override
  String get moviesTab => 'Películas';

  @override
  String get reviewsTab => 'Reseñas';

  @override
  String get unknownError => 'Error desconocido';

  @override
  String movieRelease(String date) {
    return 'Estreno: $date';
  }

  @override
  String movieRating(String rating) {
    return 'Puntuación: $rating';
  }

  @override
  String movieRuntime(int minutes) {
    return 'Duración: $minutes min';
  }

  @override
  String movieGenres(String genres) {
    return 'Géneros: $genres';
  }

  @override
  String get activitiesTab => 'Actividades';

  @override
  String get newUserActivityTab => 'Nueva Actividad';
}
