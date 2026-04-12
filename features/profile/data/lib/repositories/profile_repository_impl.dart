import 'package:core/core.dart';
import 'package:movies_data/datasources/remote/movies_remote_data_source.dart';
import 'package:movies_domain/models/movie_listing.dart';
import 'package:movies_domain/models/movie_review_listing.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final MoviesRemoteDataSource _moviesRemoteDataSource;

  ProfileRepositoryImpl(this._moviesRemoteDataSource);

  @override
  Future<Result<MovieReviewListing>> getUserReviews({
    required int page,
  }) async {
    final result = await _moviesRemoteDataSource.getMovieReviews(page: page);

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }

  @override
  Future<Result<MovieListing>> getUserFavoriteMovies({
    required String userId,
    required int page,
  }) async {
    final result = await _moviesRemoteDataSource.getUserFavoriteMovies(
      userId: userId,
      page: page,
    );

    return switch (result) {
      Success(:final data) => Success(data.toDomain()),
      Failure(:final error) => Failure(error),
    };
  }
}
