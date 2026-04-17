import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:reviews/reviews_list/reviews_screen.dart';

@RoutePage()
class ReviewsPage extends StatelessWidget {
  final int? movieId;
  final String? movieTitle;

  const ReviewsPage({super.key, this.movieId, this.movieTitle});

  @override
  Widget build(BuildContext context) => ReviewsScreen(
        getMovieReviews: GetIt.I<GetMovieReviews>(),
        movieId: movieId,
        movieTitle: movieTitle,
      );
}
