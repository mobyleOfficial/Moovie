import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_data/models/remote/remote_movie_collection.dart';
import 'package:movies_data/models/remote/remote_movie_collection_listing.dart';
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
