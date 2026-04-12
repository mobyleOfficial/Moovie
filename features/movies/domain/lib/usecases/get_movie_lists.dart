import 'package:core/core.dart';

import 'package:movies_domain/models/movie_list_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieListsParams {
  final int page;
  final String? userId;

  const GetMovieListsParams({required this.page, this.userId});
}

class GetMovieLists
    extends UseCase<GetMovieListsParams, Result<MovieListListing>> {
  final MoviesRepository _moviesRepository;

  GetMovieLists(this._moviesRepository);

  @override
  Future<Result<MovieListListing>> call([
    GetMovieListsParams? params,
  ]) async =>
      _moviesRepository.getMovieLists(
        page: params?.page ?? 1,
        userId: params?.userId,
      );
}
