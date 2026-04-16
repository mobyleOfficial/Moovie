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
  String get searchBrowseGenreCountryLanguage => 'Genre, Country & Language';

  @override
  String get searchBrowseCountry => 'Country';

  @override
  String get searchBrowseLanguage => 'Language';

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
  String get profileTabReviews => 'Reviews';

  @override
  String get profileTabLists => 'Lists';

  @override
  String get profileTabWatchlist => 'Watchlist';

  @override
  String get profileFollowers => 'Followers';

  @override
  String get profileFollowing => 'Following';

  @override
  String get profileMoviesWatched => 'Watched';

  @override
  String get profileEditProfile => 'Edit Profile';

  @override
  String get profileRecentMovies => 'Recent Movies';

  @override
  String get profileFavoriteMovies => 'Favorite Movies';

  @override
  String get profileRecentActivity => 'Recent Activity';

  @override
  String get profileMoviesSection => 'Movies';

  @override
  String get profileReviewsSection => 'Reviews';

  @override
  String get profileWatchlistSection => 'Watchlist';

  @override
  String get profileSeeAll => 'See all';

  @override
  String get socialFriendsTab => 'Friends';

  @override
  String get socialActivitiesTab => 'Activities';

  @override
  String get moviesListListsTab => 'Lists';

  @override
  String get moviesListArticlesTab => 'Articles';

  @override
  String get moviesListPopularThisWeek => 'Popular this week';

  @override
  String movieListDetailMoviesTab(int count) {
    return '$count Movies';
  }

  @override
  String movieListDetailCommentsTab(int count) {
    return '$count Comments';
  }

  @override
  String get movieListDetailCommentsPlaceholder => 'Comments coming soon';

  @override
  String get newUserActivityDraftsSection => 'Drafts';

  @override
  String get newUserActivityRecentSection => 'Recent';

  @override
  String get profileFollow => 'Follow';

  @override
  String get reviewDetailsBodyTitle => 'My Review';

  @override
  String get noResults => 'No results found';

  @override
  String get movieReviewTitle => 'Review';

  @override
  String get movieReviewNameHint => 'Review title';

  @override
  String get movieReviewAddReview => 'Add a review...';

  @override
  String get movieReviewRewatch => 'Rewatch';

  @override
  String get movieReviewFirstTime => 'First time';

  @override
  String get movieReviewTags => 'Tags';

  @override
  String get movieReviewTagMasterpiece => 'Masterpiece';

  @override
  String get movieReviewTagOverrated => 'Overrated';

  @override
  String get movieReviewTagUnderrated => 'Underrated';

  @override
  String get movieReviewTagMustWatch => 'Must Watch';

  @override
  String get movieReviewTagDisappointing => 'Disappointing';

  @override
  String get movieReviewTagFeelGood => 'Feel Good';

  @override
  String get movieReviewTagMindBending => 'Mind Bending';

  @override
  String get movieReviewTagEmotional => 'Emotional';

  @override
  String get movieReviewSend => 'Send review';

  @override
  String get deleteDraftTitle => 'Delete draft?';

  @override
  String get deleteDraftContent => 'This draft will be permanently deleted.';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get reviewEditorTitle => 'Write a review';

  @override
  String get reviewEditorPlaceholder => 'Start writing your review...';

  @override
  String get reviewEditorClear => 'Clear all';

  @override
  String get reviewEditorClearConfirmTitle => 'Clear review?';

  @override
  String get reviewEditorClearConfirmContent => 'All text will be removed.';

  @override
  String get reviewDetailsAddReview => 'Add a review...';

  @override
  String get movieListDetailShowGridView => 'Show grid view';

  @override
  String get movieListDetailShowListView => 'Show list view';

  @override
  String get emptyStateErrorTitle => 'Something went wrong';

  @override
  String get emptyStateErrorMessage =>
      'An unexpected error occurred. Please try again.';

  @override
  String get emptyStateRetry => 'Retry';

  @override
  String get emptyStateNoItemsTitle => 'Nothing here yet';

  @override
  String get emptyStateNoItemsMessage => 'There are no items to display.';
}
