import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:profile_ui/tabs/lists/user_movie_lists_screen.dart';
import 'package:profile_ui/tabs/profile_info/profile_info_screen.dart';
import 'package:profile_ui/tabs/watchlist/watchlist_screen.dart' show WatchlistScreen;
import 'package:reviews/reviews_list/reviews_screen.dart';

class ProfileScreen extends StatelessWidget {
  final GetMovieReviews getMovieReviews;

  const ProfileScreen({
    super.key,
    required this.getMovieReviews,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          MoovieTabBar(tabs: [
            l10n?.profileTabProfile ?? '',
            l10n?.profileTabDiary ?? '',
            l10n?.profileTabLists ?? '',
            l10n?.profileTabWatchlist ?? '',
          ]),
          Expanded(
            child: TabBarView(
              children: [
                const MoovieKeepAliveTab(child: ProfileInfoScreen()),
                MoovieKeepAliveTab(
                  child: ReviewsScreen(getMovieReviews: getMovieReviews),
                ),
                const MoovieKeepAliveTab(child: UserMovieListsScreen()),
                const MoovieKeepAliveTab(child: WatchlistScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
