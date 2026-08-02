import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:profile_ui/profile_bloc.dart';
import 'package:profile_ui/profile_state.dart';
import 'package:profile_ui/tabs/lists/user_movie_lists_page.dart';
import 'package:profile_ui/tabs/profile_info/profile_info_screen.dart';
import 'package:profile_ui/tabs/watchlist/watchlist_page.dart';
import 'package:reviews/reviews_list/reviews_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileCubit cubit;
  final GetMovieReviews getMovieReviews;

  const ProfileScreen({
    super.key,
    required this.cubit,
    required this.getMovieReviews,
  });

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: cubit,
        child: _ProfileScreenBody(getMovieReviews: getMovieReviews),
      );
}

class _ProfileScreenBody extends StatelessWidget {
  final GetMovieReviews getMovieReviews;

  const _ProfileScreenBody({required this.getMovieReviews});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => switch (state) {
        ProfileLoading() => const Center(child: CircularProgressIndicator()),
        ProfileError(:final message) => MuuvieEmptyState(
            title: l10n?.emptyStateErrorTitle ?? '',
            message: message,
            action: context.read<ProfileCubit>().retry,
            actionLabel: l10n?.emptyStateRetry ?? '',
          ),
        ProfileSuccess() => DefaultTabController(
            length: 4,
            child: Column(
              children: [
                MuuvieTabBar(tabs: [
                  l10n?.profileTabProfile ?? '',
                  l10n?.profileTabDiary ?? '',
                  l10n?.profileTabLists ?? '',
                  l10n?.profileTabWatchlist ?? '',
                ]),
                Expanded(
                  child: TabBarView(
                    children: [
                      const MuuvieKeepAliveTab(child: ProfileInfoScreen()),
                      MuuvieKeepAliveTab(
                        child:
                            ReviewsScreen(getMovieReviews: getMovieReviews),
                      ),
                      const MuuvieKeepAliveTab(
                          child: UserMovieListsPage()),
                      const MuuvieKeepAliveTab(child: WatchlistPage()),
                    ],
                  ),
                ),
              ],
            ),
          ),
      },
    );
  }
}
