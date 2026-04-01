import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reviews_bloc.dart';
import 'reviews_state.dart';

@RoutePage()
class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReviewsCubit(),
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