import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:reviews/review_creation/review_creation_bloc.dart';
import 'package:reviews/review_creation/review_creation_screen.dart';

@RoutePage()
class ReviewCreationPage extends StatefulWidget {
  final UpsertMovieReview upsertMovieReview;
  final int movieId;
  final String movieTitle;
  final String posterPath;
  final MovieReviewDraft? initialDraft;

  const ReviewCreationPage({
    super.key,
    required this.upsertMovieReview,
    required this.movieId,
    required this.movieTitle,
    required this.posterPath,
    this.initialDraft,
  });

  @override
  State<ReviewCreationPage> createState() => _ReviewCreationPageState();
}

class _ReviewCreationPageState extends State<ReviewCreationPage> {
  late final ReviewCreationCubit _cubit = ReviewCreationCubit(
    upsertMovieReview: widget.upsertMovieReview,
    movieId: widget.movieId,
    movieTitle: widget.movieTitle,
    posterPath: widget.posterPath,
    initialDraft: widget.initialDraft,
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ReviewCreationScreen(
        cubit: _cubit,
        movieTitle: widget.movieTitle,
        posterPath: widget.posterPath,
      );
}
