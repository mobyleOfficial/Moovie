import 'package:injectable/injectable.dart';
import 'package:movies_domain/domain.dart';

@module
abstract class MoviesDiModule {
  @injectable
  GetTrendingMovies getTrendingMovies(MoviesRepository moviesRepository) =>
      GetTrendingMovies(moviesRepository);

  @injectable
  GetMovieReviews getMovieReviews(MoviesRepository moviesRepository) =>
      GetMovieReviews(moviesRepository);

  @injectable
  GetMovieCollections getMovieCollections(MoviesRepository moviesRepository) =>
      GetMovieCollections(moviesRepository);
}
