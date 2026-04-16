import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'lib/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Moovie'**
  String get appTitle;

  /// Bottom navigation home label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Bottom navigation search label and search screen title
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Profile screen title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Home screen movies tab label
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get moviesTab;

  /// Home screen reviews tab label
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviewsTab;

  /// Fallback error message when no details are available
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// Movie release date label
  ///
  /// In en, this message translates to:
  /// **'Release: {date}'**
  String movieRelease(String date);

  /// Movie rating label
  ///
  /// In en, this message translates to:
  /// **'Rating: {rating}'**
  String movieRating(String rating);

  /// Movie runtime label
  ///
  /// In en, this message translates to:
  /// **'Runtime: {minutes} min'**
  String movieRuntime(int minutes);

  /// Movie genres label
  ///
  /// In en, this message translates to:
  /// **'Genres: {genres}'**
  String movieGenres(String genres);

  /// Bottom navigation social tab label
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get socialTab;

  /// Bottom navigation new user activity tab label
  ///
  /// In en, this message translates to:
  /// **'New Activity'**
  String get newUserActivityTab;

  /// Hint text inside the search input field
  ///
  /// In en, this message translates to:
  /// **'Movies, people, lists...'**
  String get searchHint;

  /// Section header above browse options on the search screen
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get searchBrowse;

  /// Browse by release date option
  ///
  /// In en, this message translates to:
  /// **'Release Date'**
  String get searchBrowseReleaseDate;

  /// Browse by genre option
  ///
  /// In en, this message translates to:
  /// **'Genre'**
  String get searchBrowseGenre;

  /// Browse by country and language option
  ///
  /// In en, this message translates to:
  /// **'Country & Language'**
  String get searchBrowseCountryAndLanguage;

  /// Merged browse option for genre, country and language
  ///
  /// In en, this message translates to:
  /// **'Genre, Country & Language'**
  String get searchBrowseGenreCountryLanguage;

  /// Country tab label in browse categories
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get searchBrowseCountry;

  /// Language tab label in browse categories
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get searchBrowseLanguage;

  /// Browse by streaming service option
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get searchBrowseService;

  /// Browse most popular movies option
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get searchBrowseMostPopular;

  /// Browse highest rated movies option
  ///
  /// In en, this message translates to:
  /// **'Highest Rated'**
  String get searchBrowseHighestRated;

  /// Browse most anticipated movies option
  ///
  /// In en, this message translates to:
  /// **'Most Anticipated'**
  String get searchBrowseMostAnticipated;

  /// Browse featured lists option
  ///
  /// In en, this message translates to:
  /// **'Featured Lists'**
  String get searchBrowseFeaturedLists;

  /// Profile tab label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTabProfile;

  /// Diary tab label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Diary'**
  String get profileTabDiary;

  /// Reviews tab label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get profileTabReviews;

  /// Lists tab label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get profileTabLists;

  /// Watchlist tab label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get profileTabWatchlist;

  /// Followers stat label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get profileFollowers;

  /// Following stat label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get profileFollowing;

  /// Movies watched stat label on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Watched'**
  String get profileMoviesWatched;

  /// Title for the movies watched bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Movies watched'**
  String get profileMoviesWatchedTitle;

  /// Title for the following bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Following'**
  String get profileFollowingTitle;

  /// Title for the followers bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get profileFollowersTitle;

  /// Empty state message for movies watched
  ///
  /// In en, this message translates to:
  /// **'No movies watched yet'**
  String get profileEmptyMoviesWatched;

  /// Empty state message for following list
  ///
  /// In en, this message translates to:
  /// **'Not following anyone yet'**
  String get profileEmptyFollowing;

  /// Empty state message for followers list
  ///
  /// In en, this message translates to:
  /// **'No followers yet'**
  String get profileEmptyFollowers;

  /// Edit profile button label
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get profileEditProfile;

  /// Username field label on the edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get editProfileUsernameLabel;

  /// Username field placeholder on the edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get editProfileUsernamePlaceholder;

  /// Bio field label on the edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get editProfileBioLabel;

  /// Bio field placeholder on the edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get editProfileBioPlaceholder;

  /// Change photo button label on the edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get editProfileChangePhoto;

  /// Recent movies section header on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Recent Movies'**
  String get profileRecentMovies;

  /// Favorite movies section header on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Favorite Movies'**
  String get profileFavoriteMovies;

  /// Recent activity section header on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get profileRecentActivity;

  /// Movies section header on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Movies'**
  String get profileMoviesSection;

  /// Reviews section header on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get profileReviewsSection;

  /// Watchlist section header on the profile screen
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get profileWatchlistSection;

  /// See all link label for profile sections
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get profileSeeAll;

  /// Friends tab label on the social screen
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get socialFriendsTab;

  /// Activities tab label on the social screen
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get socialActivitiesTab;

  /// Lists tab label on the movies list screen
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get moviesListListsTab;

  /// Articles tab label on the movies list screen
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get moviesListArticlesTab;

  /// Header for popular lists section
  ///
  /// In en, this message translates to:
  /// **'Popular this week'**
  String get moviesListPopularThisWeek;

  /// Movies tab label with count
  ///
  /// In en, this message translates to:
  /// **'{count} Movies'**
  String movieListDetailMoviesTab(int count);

  /// Comments tab label with count
  ///
  /// In en, this message translates to:
  /// **'{count} Comments'**
  String movieListDetailCommentsTab(int count);

  /// Placeholder for comments tab
  ///
  /// In en, this message translates to:
  /// **'Comments coming soon'**
  String get movieListDetailCommentsPlaceholder;

  /// Drafts section header on the new activity screen
  ///
  /// In en, this message translates to:
  /// **'Drafts'**
  String get newUserActivityDraftsSection;

  /// Recent searches section header on the new activity screen
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get newUserActivityRecentSection;

  /// Follow button label on public profile screen
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get profileFollow;

  /// Section header for the review body text on the review details screen
  ///
  /// In en, this message translates to:
  /// **'My Review'**
  String get reviewDetailsBodyTitle;

  /// Message shown when a search returns no results
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// App bar title for the movie review screen
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get movieReviewTitle;

  /// Hint text for the review name input field
  ///
  /// In en, this message translates to:
  /// **'Review title'**
  String get movieReviewNameHint;

  /// Placeholder text in the add review box
  ///
  /// In en, this message translates to:
  /// **'Add a review...'**
  String get movieReviewAddReview;

  /// Label for the rewatch toggle
  ///
  /// In en, this message translates to:
  /// **'Rewatch'**
  String get movieReviewRewatch;

  /// Label for the first time watching toggle
  ///
  /// In en, this message translates to:
  /// **'First time'**
  String get movieReviewFirstTime;

  /// Section header for the tags section
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get movieReviewTags;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Masterpiece'**
  String get movieReviewTagMasterpiece;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Overrated'**
  String get movieReviewTagOverrated;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Underrated'**
  String get movieReviewTagUnderrated;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Must Watch'**
  String get movieReviewTagMustWatch;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Disappointing'**
  String get movieReviewTagDisappointing;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Feel Good'**
  String get movieReviewTagFeelGood;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Mind Bending'**
  String get movieReviewTagMindBending;

  /// Predefined tag for movie review
  ///
  /// In en, this message translates to:
  /// **'Emotional'**
  String get movieReviewTagEmotional;

  /// Tooltip for the send review button in the app bar
  ///
  /// In en, this message translates to:
  /// **'Send review'**
  String get movieReviewSend;

  /// Title for the delete draft confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete draft?'**
  String get deleteDraftTitle;

  /// Content for the delete draft confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This draft will be permanently deleted.'**
  String get deleteDraftContent;

  /// Delete action label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Cancel action label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Title for the review editor bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Write a review'**
  String get reviewEditorTitle;

  /// Placeholder text for the review editor
  ///
  /// In en, this message translates to:
  /// **'Start writing your review...'**
  String get reviewEditorPlaceholder;

  /// Button to clear all text in the review editor
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get reviewEditorClear;

  /// Title for the clear review confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Clear review?'**
  String get reviewEditorClearConfirmTitle;

  /// Content for the clear review confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'All text will be removed.'**
  String get reviewEditorClearConfirmContent;

  /// Placeholder text for the add review section on the review details screen
  ///
  /// In en, this message translates to:
  /// **'Add a review...'**
  String get reviewDetailsAddReview;

  /// Tooltip for the button that switches movie list detail to grid layout
  ///
  /// In en, this message translates to:
  /// **'Show grid view'**
  String get movieListDetailShowGridView;

  /// Tooltip for the button that switches movie list detail to list layout
  ///
  /// In en, this message translates to:
  /// **'Show list view'**
  String get movieListDetailShowListView;

  /// Title for the error empty state
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get emptyStateErrorTitle;

  /// Message for the error empty state
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get emptyStateErrorMessage;

  /// Retry button label on the error empty state
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get emptyStateRetry;

  /// Title for the empty list state
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get emptyStateNoItemsTitle;

  /// Message for the empty list state
  ///
  /// In en, this message translates to:
  /// **'There are no items to display.'**
  String get emptyStateNoItemsMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
