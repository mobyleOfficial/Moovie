import 'package:core/core.dart';

import 'package:movies_domain/models/search_movies_params.dart';
import 'package:movies_domain/models/movie_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class SearchMovies extends UseCase<SearchMoviesParams, Result<MovieListing>> {
  final MoviesRepository _moviesRepository;

  SearchMovies(this._moviesRepository);

  @override
  Future<Result<MovieListing>> call([SearchMoviesParams? params]) async =>
      _moviesRepository.searchMovies(
        query: params?.query ?? '',
        page: params?.page ?? 1,
      );
}
