import 'package:get_it/get_it.dart';
import 'package:social/social_bloc.dart';
import 'package:social/social_screen.dart';
import 'package:social/tabs/activities/activities_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:user_activities/user_activities.dart';

@RoutePage()
class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  final SocialCubit _cubit = SocialCubit();
  late final ActivitiesCubit _activitiesCubit = ActivitiesCubit(
    GetIt.I<GetFriendsActivities>(),
  );

  @override
  void dispose() {
    _activitiesCubit.close();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      SocialScreen(cubit: _cubit, activitiesCubit: _activitiesCubit);
}
