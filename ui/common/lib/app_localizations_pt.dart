// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Moovie';

  @override
  String get home => 'Início';

  @override
  String get search => 'Pesquisar';

  @override
  String get profile => 'Perfil';

  @override
  String get moviesTab => 'Filmes';

  @override
  String get reviewsTab => 'Avaliações';

  @override
  String get unknownError => 'Erro desconhecido';

  @override
  String movieRelease(String date) {
    return 'Lançamento: $date';
  }

  @override
  String movieRating(String rating) {
    return 'Avaliação: $rating';
  }

  @override
  String movieRuntime(int minutes) {
    return 'Duração: $minutes min';
  }

  @override
  String movieGenres(String genres) {
    return 'Gêneros: $genres';
  }

  @override
  String get socialTab => 'Social';

  @override
  String get newUserActivityTab => 'Nova Atividade';
}
