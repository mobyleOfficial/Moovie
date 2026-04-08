import 'package:core/core.dart';

import 'package:movies_domain/models/get_movie_list_detail_params.dart';
import 'package:movies_domain/models/movie_list_detail.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieListDetail
    extends UseCase<GetMovieListDetailParams, Result<MovieListDetail>> {
  final MoviesRepository _moviesRepository;

  GetMovieListDetail(this._moviesRepository);

  @override
  Future<Result<MovieListDetail>> call([
    GetMovieListDetailParams? params,
  ]) async =>
      _moviesRepository.getMovieListDetail(
        listId: params?.listId ?? 0,
        page: params?.page ?? 1,
      );
}