import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_bloc.dart';
import 'profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit cubit;

  const ProfileScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
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
      ),
    );
  }
}
