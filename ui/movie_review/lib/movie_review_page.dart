import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:movie_review/movie_review_bloc.dart';
import 'package:movie_review/movie_review_screen.dart';

@RoutePage()
class MovieReviewPage extends StatefulWidget {
  final UpsertMovieReview upsertMovieReview;
  final int movieId;
  final String movieTitle;
  final String posterPath;
  final MovieReviewDraft? initialDraft;

  const MovieReviewPage({
    super.key,
    required this.upsertMovieReview,
    required this.movieId,
    required this.movieTitle,
    required this.posterPath,
    this.initialDraft,
  });

  @override
  State<MovieReviewPage> createState() => _MovieReviewPageState();
}

class _MovieReviewPageState extends State<MovieReviewPage> {
  late final MovieReviewCubit _cubit = MovieReviewCubit(
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
  Widget build(BuildContext context) => MovieReviewScreen(
        cubit: _cubit,
        movieTitle: widget.movieTitle,
        posterPath: widget.posterPath,
      );
}
