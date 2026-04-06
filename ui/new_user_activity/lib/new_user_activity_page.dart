import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:new_user_activity/new_user_activity_bloc.dart';
import 'package:new_user_activity/new_user_activity_screen.dart';

@RoutePage()
class NewUserActivityPage extends StatefulWidget {
  final SearchMovies searchMovies;
  final ObserveMovieReviewDraftsList observeMovieReviewDraftsList;
  final DeleteDraft deleteDraft;
  final AddRecentSearch addRecentSearch;
  final ObserveRecentSearches observeRecentSearches;

  const NewUserActivityPage({
    super.key,
    required this.searchMovies,
    required this.observeMovieReviewDraftsList,
    required this.deleteDraft,
    required this.addRecentSearch,
    required this.observeRecentSearches,
  });

  @override
  State<NewUserActivityPage> createState() => _NewUserActivityPageState();
}

class _NewUserActivityPageState extends State<NewUserActivityPage> {
  late final NewUserActivityCubit _cubit = NewUserActivityCubit(
    widget.searchMovies,
    widget.observeMovieReviewDraftsList,
    widget.deleteDraft,
    widget.addRecentSearch,
    widget.observeRecentSearches,
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      NewUserActivityScreen(cubit: _cubit);
}
