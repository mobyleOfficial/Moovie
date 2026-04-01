import 'package:core/core.dart';

import '../models/movie.dart';

abstract interface class MoviesRepository {
  Future<Result<List<Movie>>> getTrendingMovieList();
}