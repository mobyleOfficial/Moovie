import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_activity/new_user_activity_bloc.dart';
import 'package:new_user_activity/new_user_activity_state.dart';

class NewUserActivityScreen extends StatelessWidget {
  final NewUserActivityCubit cubit;

  const NewUserActivityScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.newUserActivityTab),
    ),
    body: BlocProvider.value(
      value: cubit,
      child: BlocBuilder<NewUserActivityCubit, NewUserActivityState>(
        builder: (context, state) => switch (state) {
          NewUserActivityLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          NewUserActivitySuccess() => Center(
              child: Text(AppLocalizations.of(context)!.newUserActivityTab),
            ),
          NewUserActivityError() => Center(
              child: Text(state.message),
            ),
        },
      ),
    ),
  );
}
