import 'package:core/core.dart';
import 'package:public_profile_data/datasources/remote/public_profile_remote_data_source.dart';
import 'package:public_profile_data/models/remote/remote_profile_favorite_movie.dart';
import 'package:public_profile_data/models/remote/remote_profile_recent_activity.dart';
import 'package:public_profile_data/models/remote/remote_profile_user.dart';
import 'package:public_profile_data/models/remote/remote_profile_watched_movie.dart';
import 'package:public_profile_data/models/remote/remote_profile_watchlist_item.dart';
import 'package:public_profile_data/models/remote/remote_public_profile.dart';

class PublicProfileRemoteDataSourceImpl implements PublicProfileRemoteDataSource {
  // ignore: unused_field
  final HttpClient _httpClient;

  PublicProfileRemoteDataSourceImpl(this._httpClient);

  static const _mockedFavoriteMovies = [
    RemoteProfileFavoriteMovie(id: 157336, title: 'Interstellar'),
    RemoteProfileFavoriteMovie(id: 238, title: 'The Godfather'),
    RemoteProfileFavoriteMovie(id: 496243, title: 'Parasite'),
    RemoteProfileFavoriteMovie(id: 129, title: 'Spirited Away'),
    RemoteProfileFavoriteMovie(id: 155, title: 'The Dark Knight'),
  ];

  static const _mockedRecentActivities = [
    RemoteProfileRecentActivity(action: 'Watched', movie: 'Dune: Part Two', time: '2h ago'),
    RemoteProfileRecentActivity(action: 'Reviewed', movie: 'Oppenheimer', time: '1d ago'),
    RemoteProfileRecentActivity(action: 'Added to watchlist', movie: 'The Brutalist', time: '2d ago'),
    RemoteProfileRecentActivity(action: 'Liked review of', movie: 'Anora', time: '3d ago'),
    RemoteProfileRecentActivity(action: 'Watched', movie: 'Poor Things', time: '4d ago'),
  ];

  static const _mockedWatchlist = [
    RemoteProfileWatchlistItem(id: 426063, title: 'Nosferatu'),
    RemoteProfileWatchlistItem(id: 933260, title: 'The Substance'),
    RemoteProfileWatchlistItem(id: 1084199, title: 'A Real Pain'),
    RemoteProfileWatchlistItem(id: 1064028, title: 'Emilia Perez'),
    RemoteProfileWatchlistItem(id: 974453, title: 'Nickel Boys'),
  ];

  static const _mockedMoviesWatched = [
    RemoteProfileWatchedMovie(
      id: 693134,
      title: 'Dune: Part Two',
      posterPath: '/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg',
    ),
    RemoteProfileWatchedMovie(
      id: 872585,
      title: 'Oppenheimer',
      posterPath: '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
    ),
    RemoteProfileWatchedMovie(
      id: 792307,
      title: 'Poor Things',
      posterPath: '/kCGlIMHnOm8JPXq3rXM6c5wMxcT.jpg',
    ),
    RemoteProfileWatchedMovie(
      id: 929590,
      title: 'The Zone of Interest',
      posterPath: '/hUu9zyZmDd8VZegKi1iK1Vk0RYS.jpg',
    ),
    RemoteProfileWatchedMovie(
      id: 876969,
      title: 'Society of the Snow',
      posterPath: '/2e853FDVSIso600RqAMunPxiZjq.jpg',
    ),
    RemoteProfileWatchedMovie(
      id: 872906,
      title: 'The Holdovers',
      posterPath: '/VCL6JEvXqR4n3OYejaOnOL2xsm.jpg',
    ),
  ];

  static const _mockedFollowing = [
    RemoteProfileUser(id: 'Alice Martins', displayName: 'Alice Martins', initials: 'AM'),
    RemoteProfileUser(id: 'Bruno Carvalho', displayName: 'Bruno Carvalho', initials: 'BC'),
    RemoteProfileUser(id: 'Camila Torres', displayName: 'Camila Torres', initials: 'CT'),
    RemoteProfileUser(id: 'Diego Ferreira', displayName: 'Diego Ferreira', initials: 'DF'),
  ];

  static const _mockedFollowers = [
    RemoteProfileUser(id: 'Elena Souza', displayName: 'Elena Souza', initials: 'ES'),
    RemoteProfileUser(id: 'Felipe Lima', displayName: 'Felipe Lima', initials: 'FL'),
    RemoteProfileUser(id: 'Gabriela Nunes', displayName: 'Gabriela Nunes', initials: 'GN'),
    RemoteProfileUser(id: 'Henrique Costa', displayName: 'Henrique Costa', initials: 'HC'),
    RemoteProfileUser(id: 'Alice Martins', displayName: 'Alice Martins', initials: 'AM'),
    RemoteProfileUser(id: 'Bruno Carvalho', displayName: 'Bruno Carvalho', initials: 'BC'),
  ];

  static const _mockedProfiles = <String, RemotePublicProfile>{
    'Alice Martins': RemotePublicProfile(
      id: 'Alice Martins',
      displayName: 'Alice Martins',
      initials: 'AM',
      bio: 'Drama & romance fan. Always crying at the cinema',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Bruno Carvalho': RemotePublicProfile(
      id: 'Bruno Carvalho',
      displayName: 'Bruno Carvalho',
      initials: 'BC',
      bio: 'Horror & thriller lover. The scarier the better',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Camila Torres': RemotePublicProfile(
      id: 'Camila Torres',
      displayName: 'Camila Torres',
      initials: 'CT',
      bio: 'Cinephile. Arthouse & world cinema devotee',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Diego Ferreira': RemotePublicProfile(
      id: 'Diego Ferreira',
      displayName: 'Diego Ferreira',
      initials: 'DF',
      bio: 'Just getting into movies. Learning every day',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Elena Souza': RemotePublicProfile(
      id: 'Elena Souza',
      displayName: 'Elena Souza',
      initials: 'ES',
      bio: 'Sci-fi & action aficionado. Blockbusters are my thing',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Felipe Lima': RemotePublicProfile(
      id: 'Felipe Lima',
      displayName: 'Felipe Lima',
      initials: 'FL',
      bio: 'Film critic & list maker. Check out my top 10s',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Gabriela Nunes': RemotePublicProfile(
      id: 'Gabriela Nunes',
      displayName: 'Gabriela Nunes',
      initials: 'GN',
      bio: 'Animated films fan & aspiring director',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Henrique Costa': RemotePublicProfile(
      id: 'Henrique Costa',
      displayName: 'Henrique Costa',
      initials: 'HC',
      bio: 'Film festival regular. Cannes, Sundance, you name it',
      moviesWatched: _mockedMoviesWatched,
      following: _mockedFollowing,
      followers: _mockedFollowers,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
  };

  static const _defaultProfile = RemotePublicProfile(
    id: '',
    displayName: 'Unknown User',
    initials: '??',
    bio: '',
    moviesWatched: [],
    following: [],
    followers: [],
    favoriteMovies: [],
    recentActivities: [],
    watchlist: [],
  );

  @override
  Future<Result<RemotePublicProfile>> getPublicProfile({
    required String userId,
  }) async =>
      Success(_mockedProfiles[userId] ?? _defaultProfile);
}
