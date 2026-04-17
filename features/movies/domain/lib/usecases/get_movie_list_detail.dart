import 'package:core/core.dart';

import 'package:movies_domain/models/movie_list.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieListDetailParams {
  final int listId;
  final int page;

  const GetMovieListDetailParams({
    required this.listId,
    required this.page,
  });
}

class GetMovieListDetail
    extends UseCase<GetMovieListDetailParams, Result<MovieList>> {
  final MoviesRepository _moviesRepository;

  GetMovieListDetail(this._moviesRepository);

  @override
  Future<Result<MovieList>> call([
    GetMovieListDetailParams? params,
  ]) async =>
      _moviesRepository.getMovieListDetail(
        listId: params?.listId ?? 0,
        page: params?.page ?? 1,
      );
}
