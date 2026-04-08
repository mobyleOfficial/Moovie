import 'package:social/social_bloc.dart';
import 'package:social/social_state.dart';
import 'package:social/tabs/friends/friends_screen.dart';
import 'package:social/tabs/messages/messages_screen.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialScreen extends StatelessWidget {
  final SocialCubit cubit;

  const SocialScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: cubit,
    child: BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) => switch (state) {
        SocialLoading() => const Center(child: CircularProgressIndicator()),
        SocialError() => Center(child: Text(state.message)),
        SocialSuccess() => _SocialContent(),
      },
    ),
  );
}

class _SocialContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          MoovieTabBar(tabs: [l10n?.socialFriendsTab ?? '', l10n?.socialMessagesTab ?? '']),
          const Expanded(
            child: TabBarView(
              children: [
                MoovieKeepAliveTab(child: FriendsScreen()),
                MoovieKeepAliveTab(child: MessagesScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
