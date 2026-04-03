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
  String get socialTab => 'Social';

  @override
  String get newUserActivityTab => 'Nueva Actividad';

  @override
  String get searchHint => 'Películas, personas, listas...';

  @override
  String get searchBrowse => 'Explorar';

  @override
  String get searchBrowseReleaseDate => 'Fecha de estreno';

  @override
  String get searchBrowseGenre => 'Género';

  @override
  String get searchBrowseCountryAndLanguage => 'País e idioma';

  @override
  String get searchBrowseService => 'Servicio';

  @override
  String get searchBrowseMostPopular => 'Más populares';

  @override
  String get searchBrowseHighestRated => 'Mejor valoradas';

  @override
  String get searchBrowseMostAnticipated => 'Más esperadas';

  @override
  String get searchBrowseFeaturedLists => 'Listas destacadas';

  @override
  String get profileTabProfile => 'Perfil';

  @override
  String get profileTabDiary => 'Diario';

  @override
  String get profileTabLists => 'Listas';

  @override
  String get profileTabWatchlist => 'Ver después';

  @override
  String get profileFollowers => 'Seguidores';

  @override
  String get profileFollowing => 'Siguiendo';

  @override
  String get profileMoviesWatched => 'Películas';

  @override
  String get profileEditProfile => 'Editar perfil';

  @override
  String get profileRecentMovies => 'Películas recientes';

  @override
  String get socialFriendsTab => 'Amigos';

  @override
  String get socialMessagesTab => 'Mensajes';

  @override
  String get moviesListListsTab => 'Listas';

  @override
  String get moviesListArticlesTab => 'Artículos';
}
