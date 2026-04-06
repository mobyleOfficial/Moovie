import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/movies.dart';
import 'package:objectbox/objectbox.dart';

@module
abstract class MoviesModule {
  @lazySingleton
  MoviesRemoteDataSource moviesDataSource(
    @Named('tmdb') HttpClient httpClient,
  ) => MoviesRemoteDataSourceImpl(httpClient);

  @lazySingleton
  MoviesLocalDataSource moviesLocalDataSource(Store store) =>
      MoviesLocalDataSourceImpl(
        store.box<LocalMovieReviewDraft>(),
        store.box<LocalRecentSearch>(),
      );

  @lazySingleton
  MoviesRepository moviesRepository(
    MoviesRemoteDataSource remoteDataSource,
    MoviesLocalDataSource localDataSource,
  ) =>
      MoviesRepositoryImpl(remoteDataSource, localDataSource);

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

  @injectable
  UpsertMovieReview upsertMovieReview(MoviesRepository repository) =>
      UpsertMovieReview(repository);

  @injectable
  ObserveMovieReviewDraftsList observeMovieReviewDraftsList(MoviesRepository repository) =>
      ObserveMovieReviewDraftsList(repository);

  @injectable
  DeleteDraft deleteDraft(MoviesRepository repository) =>
      DeleteDraft(repository);

  @injectable
  AddRecentSearch addRecentSearch(MoviesRepository repository) =>
      AddRecentSearch(repository);

  @injectable
  ObserveRecentSearches observeRecentSearches(MoviesRepository repository) =>
      ObserveRecentSearches(repository);
}
