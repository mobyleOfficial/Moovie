import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:reviews/reviews_list/reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  final GetMovieReviews _getMovieReviews;

  int _totalPages = 1;

  late final PagingController<int, MovieReview> pagingController =
      PagingController(
    getNextPageKey: (state) {
      final nextKey = state.nextIntPageKey;

      if (nextKey > _totalPages) {
        return null;
      }
      return nextKey;
    },
    fetchPage: _fetchPage,
  );

  final String? userId;
  final int? movieId;

  ReviewsCubit(this._getMovieReviews, {this.userId, this.movieId})
      : super(const ReviewsLoading());

  Future<List<MovieReview>> _fetchPage(int page) async {
    final result = await _getMovieReviews(
      GetMovieReviewsParams(page: page, userId: userId, movieId: movieId),
    );

    switch (result) {
      case Success(:final data):
        _totalPages = data.totalPages;
        return data.reviews;
      case Failure(:final error):
        throw Exception(error.message);
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
