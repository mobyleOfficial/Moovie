import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviews/review_details/review_details_state.dart';

class ReviewDetailsCubit extends Cubit<ReviewDetailsState> {
  ReviewDetailsCubit() : super(const ReviewDetailsLoading()) {
    _load();
  }

  void reload() => _load();

  void _load() => emit(const ReviewDetailsSuccess());
}
