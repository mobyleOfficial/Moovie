import 'package:core/core.dart';
import 'package:movies_domain/models/movie.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieDetail extends UseCase<int, Result<Movie>> {
  final MoviesRepository _moviesRepository;

  GetMovieDetail(this._moviesRepository);

  @override
  Future<Result<Movie>> call([int? params]) async {
    return _moviesRepository.getMovieDetail(movieId: params ?? 0);
  }
}
