import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:user_activities_domain/domain.dart';
import 'package:reviews/review_creation/review_creation_bloc.dart';
import 'package:reviews/review_creation/review_creation_screen.dart';

@RoutePage()
class ReviewCreationPage extends StatefulWidget {
  final int movieId;
  final String movieTitle;
  final String posterPath;
  final MovieReviewDraft? initialDraft;

  const ReviewCreationPage({
    super.key,
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
    upsertMovieReview: GetIt.I<UpsertMovieReview>(),
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