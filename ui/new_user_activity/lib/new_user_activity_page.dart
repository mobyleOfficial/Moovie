import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:new_user_activity/new_user_activity_bloc.dart';
import 'package:new_user_activity/new_user_activity_screen.dart';

@RoutePage()
class NewUserActivityPage extends StatefulWidget {
  const NewUserActivityPage({super.key});

  @override
  State<NewUserActivityPage> createState() => _NewUserActivityPageState();
}

class _NewUserActivityPageState extends State<NewUserActivityPage> {
  final NewUserActivityCubit _cubit = NewUserActivityCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NewUserActivityScreen(cubit: _cubit);
  }
}
