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

  @injectable
  GetTrendingMovies getTrendingMovies(MoviesRepository repository) =>
      GetTrendingMovies(repository);

  @injectable
  GetMovieDetail getMovieDetail(MoviesRepository repository) =>
      GetMovieDetail(repository);

  @injectable
  GetMovieReviews getMovieReviews(MoviesRepository repository) =>
      GetMovieReviews(repository);

  @injectable
  GetMovieCollections getMovieCollections(MoviesRepository repository) =>
      GetMovieCollections(repository);

  @injectable
  SearchMovies searchMovies(MoviesRepository repository) =>
      SearchMovies(repository);
}
