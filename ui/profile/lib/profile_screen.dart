import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_ui/profile_bloc.dart';
import 'package:profile_ui/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit cubit;

  const ProfileScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.profile),
          centerTitle: true,
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return switch (state) {
              ProfileLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              ProfileSuccess() => Center(
                  child: Text(l10n.profile),
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
