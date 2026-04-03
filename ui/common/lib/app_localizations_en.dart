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

  @override
  String get socialTab => 'Social';

  @override
  String get newUserActivityTab => 'New Activity';

  @override
  String get searchHint => 'Movies, people, lists...';

  @override
  String get searchBrowse => 'Browse';

  @override
  String get searchBrowseReleaseDate => 'Release Date';

  @override
  String get searchBrowseGenre => 'Genre';

  @override
  String get searchBrowseCountryAndLanguage => 'Country & Language';

  @override
  String get searchBrowseService => 'Service';

  @override
  String get searchBrowseMostPopular => 'Most Popular';

  @override
  String get searchBrowseHighestRated => 'Highest Rated';

  @override
  String get searchBrowseMostAnticipated => 'Most Anticipated';

  @override
  String get searchBrowseFeaturedLists => 'Featured Lists';

  @override
  String get profileTabProfile => 'Profile';

  @override
  String get profileTabDiary => 'Diary';

  @override
  String get profileTabLists => 'Lists';

  @override
  String get profileTabWatchlist => 'Watchlist';

  @override
  String get profileFollowers => 'Followers';

  @override
  String get profileFollowing => 'Following';

  @override
  String get profileMoviesWatched => 'Movies';

  @override
  String get profileEditProfile => 'Edit Profile';

  @override
  String get profileRecentMovies => 'Recent Movies';

  @override
  String get socialFriendsTab => 'Friends';

  @override
  String get socialMessagesTab => 'Messages';

  @override
  String get moviesListListsTab => 'Lists';

  @override
  String get moviesListArticlesTab => 'Articles';

  @override
  String get newUserActivityDraftsSection => 'Drafts';

  @override
  String get newUserActivityRecentSection => 'Recent';

  @override
  String get profileFollow => 'Follow';
}
