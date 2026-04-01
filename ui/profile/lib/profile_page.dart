import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'profile_bloc.dart';
import 'profile_screen.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileCubit _cubit = ProfileCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(cubit: _cubit);
  }
}
