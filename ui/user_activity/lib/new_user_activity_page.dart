import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:user_activity/new_user_activity_bloc.dart';
import 'package:user_activity/new_user_activity_screen.dart';

@RoutePage()
class NewUserActivityPage extends StatefulWidget {
  const NewUserActivityPage({super.key});

  @override
  State<NewUserActivityPage> createState() => _NewUserActivityPageState();
}

class _NewUserActivityPageState extends State<NewUserActivityPage> {
  late final NewUserActivityCubit _cubit = NewUserActivityCubit(
    GetIt.I<SearchMovies>(),
    GetIt.I<ObserveMovieReviewDraftsList>(),
    GetIt.I<DeleteDraft>(),
    GetIt.I<AddRecentSearch>(),
    GetIt.I<ObserveRecentSearches>(),
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