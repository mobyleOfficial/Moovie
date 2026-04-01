import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

import '../../models/remote/remote_trending_movie_listing.dart';
import 'movies_remote_data_source.dart';

@injectable
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpClient _httpClient;

  MoviesRemoteDataSourceImpl(@Named('tmdb') this._httpClient);

  @override
  Future<Result<RemoteTrendingMovieListing>> getTrendingMovieList({
    required int page,
  }) async {
    final result = await _httpClient.get<Map<String, dynamic>>(
      'trending/movie/week',
      queryParams: {'page': page},
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(RemoteTrendingMovieListing.fromJson(data)),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }
}