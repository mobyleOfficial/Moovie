import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/movies.dart';

@module
abstract class MoviesModule {
  @lazySingleton
  MoviesDataSource moviesDataSource(
    @Named('tmdb') HttpClient httpClient,
  ) => MoviesDataSourceImpl(httpClient);

  @lazySingleton
  MoviesRepository moviesRepository(MoviesDataSource dataSource) =>
      MoviesRepositoryImpl(dataSource);

  @lazySingleton
  GetTrendingMovies getTrendingMovies(MoviesRepository repository) =>
      GetTrendingMovies(repository);
}