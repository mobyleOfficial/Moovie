import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:public_profile/public_profile_info/public_profile_info_tab.dart';
import 'package:public_profile/public_profile_lists/public_profile_lists_tab.dart';
import 'package:public_profile/user_review/user_reviews_screen.dart';

class PublicProfileScreen extends StatelessWidget {
  final String userId;

  const PublicProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inTabContext = TabIndexScope.find(context) != null;

    return Scaffold(
      appBar: inTabContext ? null : AppBar(),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            MoovieTabBar(tabs: [
              l10n?.profileTabProfile ?? '',
              l10n?.profileTabReviews ?? '',
              l10n?.profileTabLists ?? '',
            ]),
            Expanded(
              child: TabBarView(
                children: [
                  MoovieKeepAliveTab(
                    child: ProfileInfoTab(userId: userId),
                  ),
                  const MoovieKeepAliveTab(
                    child: UserReviewsScreen(),
                  ),
                  MoovieKeepAliveTab(
                    child: PublicProfileListsTab(userId: userId),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
