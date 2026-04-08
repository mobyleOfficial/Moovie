import 'package:core/core.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class AddRecentSearch extends UseCase<String, Result<void>> {
  final MoviesRepository _moviesRepository;

  AddRecentSearch(this._moviesRepository);

  @override
  Future<Result<void>> call([String? params]) async =>
      _moviesRepository.addRecentSearch(query: params ?? '');
}
