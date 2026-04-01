import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_bloc.dart';
import 'profile_state.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return switch (state) {
            ProfileLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ProfileSuccess() => const Center(
                child: Text('Profile'),
              ),
            ProfileError() => Center(
                child: Text(state.message),
              ),
          };
        },
      ),
    );
  }
}