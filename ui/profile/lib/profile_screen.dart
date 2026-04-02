import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:profile_ui/tabs/diary/diary_screen.dart';
import 'package:profile_ui/tabs/lists/lists_screen.dart';
import 'package:profile_ui/tabs/profile_info/profile_info_screen.dart';
import 'package:profile_ui/tabs/watchlist/watchlist_screen.dart' show WatchlistScreen;

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          MoovieTabBar(
            tabs: [
              l10n.profileTabProfile,
              l10n.profileTabDiary,
              l10n.profileTabLists,
              l10n.profileTabWatchlist,
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                ProfileInfoScreen(),
                DiaryScreen(),
                ListsScreen(),
                WatchlistScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
