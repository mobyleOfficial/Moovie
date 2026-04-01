import 'package:injectable/injectable.dart';
import 'package:movies_domain/movies_domain.dart';

@LazySingleton(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRepositoryImpl();
}