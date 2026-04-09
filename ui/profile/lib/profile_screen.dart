import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:profile_ui/tabs/lists/user_movie_lists_screen.dart';
import 'package:profile_ui/tabs/profile_info/profile_info_screen.dart';
import 'package:profile_ui/tabs/watchlist/watchlist_screen.dart' show WatchlistScreen;
import 'package:reviews/reviews_list/reviews_screen.dart';

class ProfileScreen extends StatefulWidget {
  final GetMovieReviews getMovieReviews;

  const ProfileScreen({
    super.key,
    required this.getMovieReviews,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      children: [
        MoovieFilterChipBar(
          labels: [
            l10n?.profileTabProfile ?? '',
            l10n?.profileTabDiary ?? '',
            l10n?.profileTabLists ?? '',
            l10n?.profileTabWatchlist ?? '',
          ],
          selectedIndex: _selectedIndex,
          onSelected: (index) => setState(() => _selectedIndex = index),
        ),
        Expanded(
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              const ProfileInfoScreen(),
              ReviewsScreen(getMovieReviews: widget.getMovieReviews),
              const UserMovieListsScreen(),
              const WatchlistScreen(),
            ],
          ),
        ),
      ],
    );
  }
}
