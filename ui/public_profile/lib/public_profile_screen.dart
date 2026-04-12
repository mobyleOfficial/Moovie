import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_ui/tabs/lists/movies_lists_bloc.dart';
import 'package:movies_ui/tabs/lists/movies_lists_screen.dart';
import 'package:profile/profile.dart';
import 'package:public_profile/public_profile_info/public_profile_info_tab.dart';
import 'package:public_profile/public_profile_info/public_profile_info_bloc.dart';
import 'package:public_profile/public_profile_info/public_profile_info_state.dart';
import 'package:public_profile/user_review/user_reviews_screen.dart';

class PublicProfileScreen extends StatefulWidget {
  final PublicProfileInfoCubit cubit;
  final String userId;
  final GetUserReviews getUserReviews;
  final MoviesListsCubit listsCubit;

  const PublicProfileScreen({
    super.key,
    required this.cubit,
    required this.userId,
    required this.getUserReviews,
    required this.listsCubit,
  });

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final inTabContext = TabIndexScope.find(context) != null;

    return BlocProvider.value(
      value: widget.cubit,
      child: BlocBuilder<PublicProfileInfoCubit, PublicProfileInfoState>(
        builder: (context, state) => switch (state) {
          PublicProfileInfoLoading() => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          PublicProfileInfoError(:final message) => Scaffold(
            body: Center(child: Text(message)),
          ),
          PublicProfileInfoSuccess(:final profile) => Scaffold(
            appBar: inTabContext ? null : AppBar(title: Text(profile.displayName)),
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
                          child: ProfileInfoTab(
                            profile: profile,
                            isFollowing: _isFollowing,
                            onFollowToggle: () =>
                                setState(() => _isFollowing = !_isFollowing),
                          ),
                        ),
                        MoovieKeepAliveTab(
                          child: UserReviewsScreen(
                            getUserReviews: widget.getUserReviews,
                          ),
                        ),
                        MoovieKeepAliveTab(
                          child: MoviesListsScreen(
                            cubit: widget.listsCubit,
                            showPopularHeader: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        },
      ),
    );
  }
}
