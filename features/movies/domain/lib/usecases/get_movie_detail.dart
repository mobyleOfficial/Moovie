import 'package:core/core.dart';
import 'package:movies_domain/models/movie_detail.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieDetail extends UseCase<int, Result<MovieDetail>> {
  final MoviesRepository _moviesRepository;

  GetMovieDetail(this._moviesRepository);

  @override
  Future<Result<MovieDetail>> call([int? params]) async {
    return _moviesRepository.getMovieDetail(movieId: params ?? 0);
  }
}
