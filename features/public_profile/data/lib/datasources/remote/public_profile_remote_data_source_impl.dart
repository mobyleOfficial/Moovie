import 'package:core/core.dart';
import 'package:public_profile_data/datasources/remote/public_profile_remote_data_source.dart';
import 'package:public_profile_data/models/remote/remote_profile_favorite_movie.dart';
import 'package:public_profile_data/models/remote/remote_profile_recent_activity.dart';
import 'package:public_profile_data/models/remote/remote_profile_watchlist_item.dart';
import 'package:public_profile_data/models/remote/remote_public_profile.dart';

class PublicProfileRemoteDataSourceImpl implements PublicProfileRemoteDataSource {
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

  static const _mockedProfiles = <String, RemotePublicProfile>{
    'Alice Martins': RemotePublicProfile(
      id: 'Alice Martins',
      displayName: 'Alice Martins',
      initials: 'AM',
      bio: 'Drama & romance fan. Always crying at the cinema',
      moviesWatched: 312,
      following: 48,
      followers: 204,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Bruno Carvalho': RemotePublicProfile(
      id: 'Bruno Carvalho',
      displayName: 'Bruno Carvalho',
      initials: 'BC',
      bio: 'Horror & thriller lover. The scarier the better',
      moviesWatched: 187,
      following: 22,
      followers: 95,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Camila Torres': RemotePublicProfile(
      id: 'Camila Torres',
      displayName: 'Camila Torres',
      initials: 'CT',
      bio: 'Cinephile. Arthouse & world cinema devotee',
      moviesWatched: 540,
      following: 76,
      followers: 413,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Diego Ferreira': RemotePublicProfile(
      id: 'Diego Ferreira',
      displayName: 'Diego Ferreira',
      initials: 'DF',
      bio: 'Just getting into movies. Learning every day',
      moviesWatched: 95,
      following: 14,
      followers: 32,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Elena Souza': RemotePublicProfile(
      id: 'Elena Souza',
      displayName: 'Elena Souza',
      initials: 'ES',
      bio: 'Sci-fi & action aficionado. Blockbusters are my thing',
      moviesWatched: 228,
      following: 33,
      followers: 167,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Felipe Lima': RemotePublicProfile(
      id: 'Felipe Lima',
      displayName: 'Felipe Lima',
      initials: 'FL',
      bio: 'Film critic & list maker. Check out my top 10s',
      moviesWatched: 413,
      following: 58,
      followers: 340,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Gabriela Nunes': RemotePublicProfile(
      id: 'Gabriela Nunes',
      displayName: 'Gabriela Nunes',
      initials: 'GN',
      bio: 'Animated films fan & aspiring director',
      moviesWatched: 76,
      following: 10,
      followers: 43,
      favoriteMovies: _mockedFavoriteMovies,
      recentActivities: _mockedRecentActivities,
      watchlist: _mockedWatchlist,
    ),
    'Henrique Costa': RemotePublicProfile(
      id: 'Henrique Costa',
      displayName: 'Henrique Costa',
      initials: 'HC',
      bio: 'Film festival regular. Cannes, Sundance, you name it',
      moviesWatched: 601,
      following: 92,
      followers: 589,
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
    moviesWatched: 0,
    following: 0,
    followers: 0,
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
