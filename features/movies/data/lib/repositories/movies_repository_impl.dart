import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_domain/domain.dart';

import '../datasources/movies_data_source.dart';

@LazySingleton(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesDataSource _dataSource;

  MoviesRepositoryImpl(this._dataSource);

  @override
  Future<Result<List<Movie>>> getTrendingMovieList() async {
    final result = await _dataSource.getTrendingMovieList();

    return switch (result) {
      Success(:final data) => Success(data.map((m) => m.toDomain()).toList()),
      Failure(:final error) => Failure(error),
    };
  }
}