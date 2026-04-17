import 'package:core/core.dart';

import 'package:movies_domain/models/movie_review_listing.dart';
import 'package:movies_domain/repositories/movies_repository.dart';

class GetMovieReviewsParams {
  final int page;
  final String? userId;
  final int? movieId;

  const GetMovieReviewsParams({required this.page, this.userId, this.movieId});
}

class GetMovieReviews
    extends UseCase<GetMovieReviewsParams, Result<MovieReviewListing>> {
  final MoviesRepository _moviesRepository;

  GetMovieReviews(this._moviesRepository);

  @override
  Future<Result<MovieReviewListing>> call([
    GetMovieReviewsParams? params,
  ]) async =>
      _moviesRepository.getMovieReviews(
        page: params?.page ?? 1,
        userId: params?.userId,
        movieId: params?.movieId,
      );
}
