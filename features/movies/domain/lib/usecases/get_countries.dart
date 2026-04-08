import 'package:core/core.dart';
import 'package:movies_domain/models/country.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetCountries extends UseCase<void, Result<List<Country>>> {
  final MoviesRepository _moviesRepository;

  GetCountries(this._moviesRepository);

  @override
  Future<Result<List<Country>>> call([void params]) async =>
      _moviesRepository.getCountries();
}
