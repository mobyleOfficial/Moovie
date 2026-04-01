import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'reviews_bloc.dart';
import 'reviews_screen.dart';

@RoutePage()
class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final ReviewsCubit _cubit = ReviewsCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReviewsScreen(cubit: _cubit);
  }
}
