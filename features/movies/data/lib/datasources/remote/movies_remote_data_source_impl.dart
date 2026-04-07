import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_data/models/remote/remote_movie_collection.dart';
import 'package:movies_data/models/remote/remote_movie_collection_listing.dart';
import 'package:movies_data/models/remote/remote_movie_list.dart';
import 'package:movies_data/models/remote/remote_movie_list_listing.dart';
import 'package:movies_data/models/remote/remote_movie_detail.dart';
import 'package:movies_data/models/remote/remote_movie_review.dart';
import 'package:movies_data/models/remote/remote_movie_review_listing.dart';
import 'package:movies_data/models/remote/remote_trending_movie_listing.dart';

@injectable
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpClient _httpClient;

  MoviesRemoteDataSourceImpl(@Named('tmdb') this._httpClient);

  static const _mockedReviews = [
    RemoteMovieReview(id: 693134, title: 'Dune: Part Two', date: 'Mar 15, 2024', rating: 4.5),
    RemoteMovieReview(id: 872585, title: 'Oppenheimer', date: 'Mar 10, 2024', rating: 5.0),
    RemoteMovieReview(id: 792307, title: 'Poor Things', date: 'Mar 5, 2024', rating: 4.0),
    RemoteMovieReview(id: 929590, title: 'The Zone of Interest', date: 'Feb 28, 2024', rating: 3.5),
    RemoteMovieReview(id: 876969, title: 'Society of the Snow', date: 'Feb 20, 2024', rating: 4.0),
    RemoteMovieReview(id: 976573, title: 'Past Lives', date: 'Feb 14, 2024', rating: 4.5),
    RemoteMovieReview(id: 913209, title: 'Anatomy of a Fall', date: 'Feb 10, 2024', rating: 4.0),
    RemoteMovieReview(id: 840430, title: 'The Holdovers', date: 'Feb 5, 2024', rating: 4.5),
    RemoteMovieReview(id: 346698, title: 'Barbie', date: 'Jan 28, 2024', rating: 3.5),
    RemoteMovieReview(id: 507089, title: 'Five Nights at Freddy\'s', date: 'Jan 20, 2024', rating: 3.0),
    RemoteMovieReview(id: 609681, title: 'The Beekeeper', date: 'Jan 15, 2024', rating: 3.5),
    RemoteMovieReview(id: 940551, title: 'Migration', date: 'Jan 10, 2024', rating: 4.0),
    RemoteMovieReview(id: 866398, title: 'The Brutalist', date: 'Jan 5, 2024', rating: 4.5),
    RemoteMovieReview(id: 1064028, title: 'Anora', date: 'Dec 28, 2023', rating: 5.0),
    RemoteMovieReview(id: 558449, title: 'Animal', date: 'Dec 20, 2023', rating: 3.0),
    RemoteMovieReview(id: 753342, title: 'Napoleon', date: 'Dec 15, 2023', rating: 3.5),
  ];

  static const _mockedCollections = [
    RemoteMovieCollection(title: 'Best of 2024', movieCount: 24),
    RemoteMovieCollection(title: 'Essential Sci-Fi', movieCount: 18),
    RemoteMovieCollection(title: 'Weekend Picks', movieCount: 12),
    RemoteMovieCollection(title: 'Must Watch Classics', movieCount: 30),
    RemoteMovieCollection(title: 'Horror Gems', movieCount: 15),
    RemoteMovieCollection(title: 'A24 Favorites', movieCount: 22),
    RemoteMovieCollection(title: 'Oscar Winners', movieCount: 20),
    RemoteMovieCollection(title: 'Hidden Gems 2023', movieCount: 16),
    RemoteMovieCollection(title: 'Action Blockbusters', movieCount: 25),
    RemoteMovieCollection(title: 'Indie Darlings', movieCount: 14),
    RemoteMovieCollection(title: 'Documentary Essentials', movieCount: 10),
    RemoteMovieCollection(title: 'Animation Masterpieces', movieCount: 19),
  ];

  static const _mockedLists = [
    RemoteMovieList(
      id: 1,
      name: 'Weekend Watchlist',
      creator: 'Sarah Chen',
      description: 'Perfect movies for a lazy weekend. A curated selection of feel-good films, cozy dramas, and light-hearted comedies that pair perfectly with a blanket and some popcorn. Whether you are looking for something to watch solo or with the whole family, this list has you covered with titles that range from critically acclaimed indie gems to crowd-pleasing blockbusters. Grab your favorite snacks, dim the lights, and let these stories transport you somewhere wonderful without ever leaving your couch.',
      movieCount: 12,
      posterPaths: ['/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg'],
    ),
    RemoteMovieList(
      id: 2,
      name: 'Mind-Bending Thrillers',
      creator: 'Jake Morrison',
      description: 'Films that will keep you guessing until the very last frame. From psychological twists to reality-warping narratives, these movies demand your full attention. Every entry on this list was chosen because it does something unexpected with the thriller genre — whether it is an unreliable narrator, a time-loop puzzle, or a slow-burn mystery that completely recontextualizes everything you thought you knew. Perfect for viewers who love dissecting plot details and rewatching scenes to catch hidden clues they missed the first time around.',
      movieCount: 18,
      posterPaths: ['/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg', '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg'],
    ),
    RemoteMovieList(
      id: 3,
      name: 'Feel-Good Classics',
      creator: 'Emma Wright',
      description: 'Guaranteed to brighten your day. Timeless films that never fail to put a smile on your face, from beloved rom-coms to heartwarming family favorites.',
      movieCount: 24,
      posterPaths: ['/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg'],
    ),
    RemoteMovieList(
      id: 4,
      name: 'Foreign Language Gems',
      creator: 'Luca Rossi',
      description: 'The best of world cinema. Explore extraordinary stories from every corner of the globe — from Korean thrillers to French dramas to Japanese animation. This collection celebrates the incredible diversity of international filmmaking, featuring works that have won top prizes at Cannes, Venice, Berlin, and beyond. Each film offers a window into a different culture and storytelling tradition, proving that great cinema transcends language barriers. Subtitles included, of course, because as Bong Joon-ho once said, once you overcome the one-inch-tall barrier of subtitles, you will be introduced to so many more amazing films.',
      movieCount: 15,
      posterPaths: ['/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg'],
    ),
    RemoteMovieList(
      id: 5,
      name: 'Director\'s Cut',
      creator: 'Mia Tanaka',
      description: 'Essential films from legendary directors. A journey through the filmographies of cinema\'s greatest visionaries, from Kubrick to Villeneuve. This list spans decades of filmmaking excellence, highlighting the defining works of auteurs who shaped the language of cinema itself. You will find everything from Hitchcock\'s masterful suspense to Scorsese\'s gritty character studies, from Spielberg\'s sense of wonder to Nolan\'s architectural storytelling. Each film is not just entertainment but a masterclass in the craft of directing.',
      movieCount: 30,
      posterPaths: ['/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg'],
    ),
    RemoteMovieList(
      id: 6,
      name: 'Underrated 2024',
      creator: 'Noah Kim',
      description: 'Great films you might have missed this year. Hidden treasures that flew under the radar but deserve your attention.',
      movieCount: 10,
      posterPaths: ['/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', '/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg', '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg'],
    ),
    RemoteMovieList(
      id: 7,
      name: 'Sci-Fi Essentials',
      creator: 'Alex Rivera',
      description: 'Must-watch science fiction from across the decades. From space operas to dystopian futures, these films explore what it means to be human. This collection traces the evolution of the genre from the golden age of practical effects to the modern era of photorealistic CGI, but what ties every entry together is the power of ideas. Whether it is a quiet contemplation of artificial intelligence, a sprawling interstellar adventure, or a claustrophobic survival horror set on a derelict spaceship, each film uses speculative premises to ask profound questions about identity, technology, and our place in the universe.',
      movieCount: 22,
      posterPaths: ['/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg'],
    ),
    RemoteMovieList(
      id: 8,
      name: 'Date Night Picks',
      creator: 'Olivia Hart',
      description: 'Romantic and fun movies for two. Whether you\'re in the mood for a sweeping romance or a quirky comedy, these films set the perfect tone.',
      movieCount: 16,
      posterPaths: ['/vpnVM9B6NMmQpWeZvzLbVd9dTSA.jpg', '/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg', '/qJ2tW6WMUDux911BTUgDYCrmpGe.jpg'],
    ),
    RemoteMovieList(
      id: 9,
      name: 'Comfort Rewatches',
      creator: 'Ben Torres',
      description: 'Movies worth watching again and again. The cinematic equivalent of comfort food — films you return to like old friends. There is something deeply satisfying about revisiting a movie you already love: you notice new details in the cinematography, catch subtle foreshadowing you missed before, and rediscover why certain scenes moved you in the first place. This list is full of films that reward repeat viewings, from endlessly quotable comedies to epic adventures that feel just as thrilling the tenth time around.',
      movieCount: 20,
      posterPaths: ['/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg', '/pB8BM7pdSp6B6Ih7QZ4DrQ3PmJK.jpg', '/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg'],
    ),
    RemoteMovieList(
      id: 10,
      name: 'Award Season Contenders',
      creator: 'Priya Sharma',
      description: 'This year\'s Oscar hopefuls. The most talked-about performances, directing achievements, and screenplays competing for gold.',
      movieCount: 14,
      posterPaths: ['/7WsyChQLEftFiDhRDpZFHSunFD2.jpg', '/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', '/gPbM0MK8CP8A174kI2PGjGVdWHN.jpg', '/8b8R8l88Qje9dn9OE8PY05Nez7C.jpg'],
    ),
  ];

  static const int _pageSize = 4;

  @override
  Future<Result<RemoteTrendingMovieListing>> getTrendingMovieList({
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'trending/movie/week',
      queryParams: {'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteTrendingMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteMovieDetail>> getMovieDetail({
    required int movieId,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'movie/$movieId',
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteMovieDetail.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<RemoteMovieReviewListing>> getMovieReviews({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedReviews.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageReviews = _mockedReviews.sublist(
      startIndex.clamp(0, _mockedReviews.length),
      endIndex.clamp(0, _mockedReviews.length),
    );

    return Success(RemoteMovieReviewListing(
      totalPages: totalPages,
      totalResults: _mockedReviews.length,
      reviews: pageReviews,
    ));
  }

  @override
  Future<Result<RemoteMovieCollectionListing>> getMovieCollections({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedCollections.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageCollections = _mockedCollections.sublist(
      startIndex.clamp(0, _mockedCollections.length),
      endIndex.clamp(0, _mockedCollections.length),
    );

    return Success(RemoteMovieCollectionListing(
      totalPages: totalPages,
      totalResults: _mockedCollections.length,
      collections: pageCollections,
    ));
  }

  @override
  Future<Result<RemoteMovieListListing>> getMovieLists({
    required int page,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final totalPages = (_mockedLists.length / _pageSize).ceil();
    final startIndex = (page - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    final pageLists = _mockedLists.sublist(
      startIndex.clamp(0, _mockedLists.length),
      endIndex.clamp(0, _mockedLists.length),
    );

    return Success(RemoteMovieListListing(
      totalPages: totalPages,
      totalResults: _mockedLists.length,
      lists: pageLists,
    ));
  }

  @override
  Future<Result<RemoteTrendingMovieListing>> searchMovies({
    required String query,
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'search/movie',
      queryParams: {'query': query, 'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteTrendingMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }
}
