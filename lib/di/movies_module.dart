import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/movies.dart';

@module
abstract class MoviesModule {
  @lazySingleton
  MoviesRemoteDataSource moviesDataSource(
    @Named('tmdb') HttpClient httpClient,
  ) => MoviesRemoteDataSourceImpl(httpClient);

  @lazySingleton
  MoviesRepository moviesRepository(MoviesRemoteDataSource dataSource) =>
      MoviesRepositoryImpl(dataSource);

  @lazySingleton
  GetTrendingMovies getTrendingMovies(MoviesRepository repository) =>
      GetTrendingMovies(repository);
}