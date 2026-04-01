import 'package:core/core.dart';

import '../models/movie.dart';
import '../repositories/movies_repository.dart';

class GetTrendingMovies extends UseCase<void, Result<List<Movie>>> {
  final MoviesRepository _moviesRepository;

  GetTrendingMovies(this._moviesRepository);

  @override
  Future<Result<List<Movie>>> call([void params]) async {
    return _moviesRepository.getTrendingMovieList();
  }
}