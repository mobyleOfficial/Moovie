import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/movie_model.dart';
import 'movies_data_source.dart';

@injectable
class MoviesDataSourceImpl implements MoviesDataSource {
  final HttpClient _httpClient;

  MoviesDataSourceImpl(@Named('tmdb') this._httpClient);

  @override
  Future<Result<List<MovieModel>>> getTrendingMovieList() async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'trending/movie/week',
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) => Success(
          (data['results'] as List<dynamic>)
              .cast<Map<String, dynamic>>()
              .map(MovieModel.fromJson)
              .toList(),
        ),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }
}