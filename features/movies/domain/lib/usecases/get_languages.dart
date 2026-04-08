import 'package:core/core.dart';
import 'package:movies_domain/models/language.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetLanguages extends UseCase<void, Result<List<Language>>> {
  final MoviesRepository _moviesRepository;

  GetLanguages(this._moviesRepository);

  @override
  Future<Result<List<Language>>> call([void params]) async =>
      _moviesRepository.getLanguages();
}
