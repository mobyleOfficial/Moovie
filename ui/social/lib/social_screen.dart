import 'package:social/social_bloc.dart';
import 'package:social/social_state.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialScreen extends StatelessWidget {
  final SocialCubit cubit;

  const SocialScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<SocialCubit, SocialState>(
        builder: (context, state) {
          return switch (state) {
            SocialLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            SocialSuccess() => Center(
                child: Text(AppLocalizations.of(context)!.socialTab),
              ),
            SocialError() => Center(
                child: Text(state.message),
              ),
          };
        },
      ),
    );
  }
}
