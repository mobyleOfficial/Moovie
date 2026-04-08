import 'package:core/core.dart';
import 'package:movies_domain/models/genre.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetGenres extends UseCase<void, Result<List<Genre>>> {
  final MoviesRepository _moviesRepository;

  GetGenres(this._moviesRepository);

  @override
  Future<Result<List<Genre>>> call([void params]) async =>
      _moviesRepository.getGenres();
}
