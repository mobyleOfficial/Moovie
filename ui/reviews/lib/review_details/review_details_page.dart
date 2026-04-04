import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:reviews/review_details/review_details_bloc.dart';
import 'package:reviews/review_details/review_details_screen.dart';

@RoutePage()
class ReviewDetailsPage extends StatefulWidget {
  final String movieTitle;
  final String reviewDate;
  final double rating;
  final int posterColorIndex;

  const ReviewDetailsPage({
    super.key,
    required this.movieTitle,
    required this.reviewDate,
    required this.rating,
    required this.posterColorIndex,
  });

  @override
  State<ReviewDetailsPage> createState() => _ReviewDetailsPageState();
}

class _ReviewDetailsPageState extends State<ReviewDetailsPage> {
  late final ReviewDetailsCubit _cubit = ReviewDetailsCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ReviewDetailsScreen(
        cubit: _cubit,
        movieTitle: widget.movieTitle,
        reviewDate: widget.reviewDate,
        rating: widget.rating,
        posterColorIndex: widget.posterColorIndex,
      );
}
