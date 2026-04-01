import 'package:core/core.dart';

import '../models/movie_model.dart';

abstract interface class MoviesDataSource {
  Future<Result<List<MovieModel>>> getTrendingMovieList();
}