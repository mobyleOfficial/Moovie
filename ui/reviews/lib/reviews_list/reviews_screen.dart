import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviews/reviews_list/reviews_bloc.dart';
import 'package:reviews/reviews_list/reviews_state.dart';

class ReviewsScreen extends StatelessWidget {
  final ReviewsCubit cubit;

  const ReviewsScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          return switch (state) {
            ReviewsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ReviewsSuccess() => Center(
                child: Text(AppLocalizations.of(context)!.reviewsTab),
              ),
            ReviewsError() => Center(
                child: Text(state.message),
              ),
          };
        },
      ),
    );
  }
}
