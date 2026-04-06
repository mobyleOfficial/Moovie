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
  Future<Result<void>> upsertMovieReview({
    required MovieReviewDraft draft,
    required MovieReviewStatus status,
  }) async {
    try {
      _localDataSource
          .upsertMovieReviewDraft(LocalMovieReviewDraft.fromDomain(draft, status));
      return const Success(null);
    } catch (_) {
      return const Failure(AppError.unknown);
    }
  }

  @override
  Stream<List<MovieReviewDraft>> observeMovieReviewDraftsList() =>
      _localDataSource.watchDrafts().map(
            (localDrafts) =>
                localDrafts.map((draft) => draft.toDomain()).toList(),
          );

  @override
  Future<Result<void>> deleteDraft({required int movieId}) async {
    try {
      _localDataSource.deleteDraftByMovieId(movieId);
      return const Success(null);
    } catch (_) {
      return const Failure(AppError.unknown);
    }
  }
}
