import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_domain/domain.dart';

import 'package:movies_data/datasources/local/movies_local_data_source.dart';
import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_data/models/local/local_movie_review_draft.dart';

@LazySingleton(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource _dataSource;
  final MoviesLocalDataSource _localDataSource;

  MoviesRepositoryImpl(this._dataSource, this._localDataSource);

  @override
  Future<Result<TrendingMovieListing>> getTrendingMovieList({
    required int page,
  }) async {
    final result = await _dataSource.getTrendingMovieList(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<MovieDetail>> getMovieDetail({required int movieId}) async {
    final result = await _dataSource.getMovieDetail(movieId: movieId);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<MovieReviewListing>> getMovieReviews({
    required int page,
  }) async {
    final result = await _dataSource.getMovieReviews(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<MovieCollectionListing>> getMovieCollections({
    required int page,
  }) async {
    final result = await _dataSource.getMovieCollections(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<MovieListListing>> getMovieLists({
    required int page,
  }) async {
    final result = await _dataSource.getMovieLists(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<MovieListDetail>> getMovieListDetail({
    required int listId,
    required int page,
  }) async {
    final result = await _dataSource.getMovieListDetail(listId: listId, page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<TrendingMovieListing>> searchMovies({
    required String query,
    required int page,
  }) async {
    final result = await _dataSource.searchMovies(query: query, page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<TrendingMovieListing>> discoverMovies({
    required int page,
    int? primaryReleaseYear,
    String? releaseDateGte,
    String? releaseDateLte,
    String? sortBy,
    String? withGenres,
    String? withOriginalLanguage,
    String? withOriginCountry,
  }) async {
    final result = await _dataSource.discoverMovies(
      page: page,
      primaryReleaseYear: primaryReleaseYear,
      releaseDateGte: releaseDateGte,
      releaseDateLte: releaseDateLte,
      sortBy: sortBy,
      withGenres: withGenres,
      withOriginalLanguage: withOriginalLanguage,
      withOriginCountry: withOriginCountry,
    );

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<List<Genre>>> getGenres() async {
    final result = await _dataSource.getGenres();

    return switch (result) {
      Success(:final data) =>
        Success(data.map((g) => g.toDomain()).toList()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<List<Country>>> getCountries() async {
    final result = await _dataSource.getCountries();

    return switch (result) {
      Success(:final data) =>
        Success(data.map((c) => c.toDomain()).toList()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<List<Language>>> getLanguages() async {
    final result = await _dataSource.getLanguages();

    return switch (result) {
      Success(:final data) =>
        Success(data.map((l) => l.toDomain()).toList()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Result<void> upsertMovieReview({
    required MovieReviewDraft draft,
    required MovieReviewStatus status,
  }) =>
      _localDataSource
          .upsertMovieReviewDraft(LocalMovieReviewDraft.fromDomain(draft, status));

  @override
  Stream<List<MovieReviewDraft>> observeMovieReviewDraftsList() =>
      _localDataSource.observeDraftsList().map(
            (localDrafts) =>
                localDrafts.map((draft) => draft.toDomain()).toList(),
          );

  @override
  Result<void> deleteDraft({required int movieId}) =>
      _localDataSource.deleteDraftByMovieId(movieId);

  @override
  Result<void> addRecentSearch({required String query}) =>
      _localDataSource.addRecentSearch(query);

  @override
  Stream<List<RecentSearch>> observeRecentSearches() =>
      _localDataSource.watchRecentSearches().map(
            (localSearches) =>
                localSearches.map((search) => search.toDomain()).toList(),
          );
}
