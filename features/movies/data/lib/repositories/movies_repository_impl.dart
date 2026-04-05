import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_domain/domain.dart';

import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';

@LazySingleton(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource _dataSource;

  MoviesRepositoryImpl(this._dataSource);

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
}
