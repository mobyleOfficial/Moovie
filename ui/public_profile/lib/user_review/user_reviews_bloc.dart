import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';
import 'package:public_profile/user_review/user_reviews_state.dart';

class UserReviewsCubit extends Cubit<UserReviewsState> {
  final GetUserReviews _getUserReviews;

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

  UserReviewsCubit(this._getUserReviews) : super(const UserReviewsLoading());

  Future<List<MovieReview>> _fetchPage(int page) async {
    final result = await _getUserReviews(page);

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
