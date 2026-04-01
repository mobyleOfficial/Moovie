import 'package:flutter_bloc/flutter_bloc.dart';

import 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(const ReviewsLoading());
}