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
}