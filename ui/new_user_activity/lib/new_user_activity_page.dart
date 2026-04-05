import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:new_user_activity/new_user_activity_bloc.dart';
import 'package:new_user_activity/new_user_activity_screen.dart';

@RoutePage()
class NewUserActivityPage extends StatefulWidget {
  final SearchMovies searchMovies;

  const NewUserActivityPage({super.key, required this.searchMovies});

  @override
  State<NewUserActivityPage> createState() => _NewUserActivityPageState();
}

class _NewUserActivityPageState extends State<NewUserActivityPage> {
  late final NewUserActivityCubit _cubit =
      NewUserActivityCubit(widget.searchMovies);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      NewUserActivityScreen(cubit: _cubit);
}
