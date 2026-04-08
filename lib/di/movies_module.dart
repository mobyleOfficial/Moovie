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
  MoviesLocalDataSource moviesLocalDataSource(
    Store store,
    LocalClient localClient,
  ) =>
      MoviesLocalDataSourceImpl(
        store.box<LocalMovieReviewDraft>(),
        store.box<LocalRecentSearch>(),
        localClient,
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
  GetMovieLists getMovieLists(MoviesRepository repository) =>
      GetMovieLists(repository);

  @injectable
  GetMovieListDetail getMovieListDetail(MoviesRepository repository) =>
      GetMovieListDetail(repository);

  @injectable
  DiscoverMovies discoverMovies(MoviesRepository repository) =>
      DiscoverMovies(repository);

  @injectable
  GetGenres getGenres(MoviesRepository repository) =>
      GetGenres(repository);

  @injectable
  GetCountries getCountries(MoviesRepository repository) =>
      GetCountries(repository);

  @injectable
  GetLanguages getLanguages(MoviesRepository repository) =>
      GetLanguages(repository);

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
