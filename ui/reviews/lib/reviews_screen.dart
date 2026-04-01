import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reviews_bloc.dart';
import 'reviews_state.dart';

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
            ReviewsSuccess() => const Center(
                child: Text('Reviews'),
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
