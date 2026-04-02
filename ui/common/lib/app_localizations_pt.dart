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

  @override
  String get searchHint => 'Filmes, pessoas, listas...';

  @override
  String get searchBrowse => 'Explorar';

  @override
  String get searchBrowseReleaseDate => 'Data de lançamento';

  @override
  String get searchBrowseGenre => 'Gênero';

  @override
  String get searchBrowseCountryAndLanguage => 'País e idioma';

  @override
  String get searchBrowseService => 'Serviço';

  @override
  String get searchBrowseMostPopular => 'Mais populares';

  @override
  String get searchBrowseHighestRated => 'Mais bem avaliados';

  @override
  String get searchBrowseMostAnticipated => 'Mais aguardados';

  @override
  String get searchBrowseFeaturedLists => 'Listas em destaque';

  @override
  String get profileTabProfile => 'Perfil';

  @override
  String get profileTabDiary => 'Diário';

  @override
  String get profileTabLists => 'Listas';

  @override
  String get profileTabWatchlist => 'Lista de desejos';

  @override
  String get profileFollowers => 'Seguidores';

  @override
  String get profileFollowing => 'Seguindo';

  @override
  String get profileMoviesWatched => 'Filmes';

  @override
  String get profileEditProfile => 'Editar perfil';

  @override
  String get profileRecentMovies => 'Filmes recentes';
}
