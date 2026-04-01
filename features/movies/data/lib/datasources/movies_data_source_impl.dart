import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../models/trending_movie_listing_model.dart';
import 'movies_data_source.dart';

@injectable
class MoviesDataSourceImpl implements MoviesDataSource {
  final HttpClient _httpClient;

  MoviesDataSourceImpl(@Named('tmdb') this._httpClient);

  @override
  Future<Result<TrendingMovieListingModel>> getTrendingMovieList({
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'trending/movie/week',
      queryParams: {'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(TrendingMovieListingModel.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }
}