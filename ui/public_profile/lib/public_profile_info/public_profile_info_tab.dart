import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies_ui/favorite_movies/favorite_movies_router.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:movies_ui/watch_list/watch_list_router.dart';
import 'package:public_profile/public_profile_info/public_profile_info_bloc.dart';
import 'package:public_profile/public_profile_info/public_profile_info_state.dart';
import 'package:public_profile_domain/models/public_profile.dart';
import 'package:public_profile_domain/usecases/get_public_profile.dart';

class ProfileInfoTab extends StatefulWidget {
  final String userId;

  const ProfileInfoTab({
    super.key,
    required this.userId,
  });

  @override
  State<ProfileInfoTab> createState() => _ProfileInfoTabState();
}

class _ProfileInfoTabState extends State<ProfileInfoTab> {
  late final PublicProfileInfoCubit _cubit = PublicProfileInfoCubit(
    getPublicProfile: GetIt.I<GetPublicProfile>(),
    userId: widget.userId,
  );
  bool _isFollowing = false;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<PublicProfileInfoCubit, PublicProfileInfoState>(
          builder: (context, state) => switch (state) {
            PublicProfileInfoLoading() =>
              const Center(child: CircularProgressIndicator()),
            PublicProfileInfoError(:final message) =>
              Center(child: Text(message)),
            PublicProfileInfoSuccess(:final profile) => _ProfileInfoContent(
                profile: profile,
                isFollowing: _isFollowing,
                onFollowToggle: () =>
                    setState(() => _isFollowing = !_isFollowing),
              ),
          },
        ),
      );
}

class _ProfileInfoContent extends StatelessWidget {
  final PublicProfile profile;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  const _ProfileInfoContent({
    required this.profile,
    required this.isFollowing,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    final posterColors = [
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.primaryContainer,
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Semantics(
            label: profile.displayName,
            image: true,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: colorScheme.secondaryContainer,
              child: ExcludeSemantics(
                child: Text(
                  profile.initials,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            profile.displayName,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            profile.bio,
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Semantics(
            label:
                '${profile.moviesWatched} ${l10n?.profileMoviesWatched ?? ''}, ${profile.following} ${l10n?.profileFollowing ?? ''}, ${profile.followers} ${l10n?.profileFollowers ?? ''}',
            excludeSemantics: true,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ProfileStat(
                    value: '${profile.moviesWatched}',
                    label: l10n?.profileMoviesWatched ?? '',
                  ),
                  VerticalDivider(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                  _ProfileStat(
                    value: '${profile.following}',
                    label: l10n?.profileFollowing ?? '',
                  ),
                  VerticalDivider(
                    color: colorScheme.outlineVariant,
                    width: 1,
                  ),
                  _ProfileStat(
                    value: '${profile.followers}',
                    label: l10n?.profileFollowers ?? '',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onFollowToggle,
              style: isFollowing
                  ? OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSurfaceVariant,
                      side: BorderSide(color: colorScheme.outlineVariant),
                    )
                  : OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.onSecondaryContainer,
                      side:
                          BorderSide(color: colorScheme.onSecondaryContainer),
                    ),
              child: Text(
                isFollowing ? (l10n?.profileFollowing ?? '') : (l10n?.profileFollow ?? ''),
              ),
            ),
          ),
          const SizedBox(height: 28),
          _SectionHeader(
            title: l10n?.profileFavoriteMovies ?? '',
            seeAllLabel: l10n?.profileSeeAll ?? '',
            onSeeAll: () => context.router.push(
              FavoriteMoviesRoute(
                userId: profile.id,
                userName: profile.displayName,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: profile.favoriteMovies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Semantics(
                label: profile.favoriteMovies[index].title,
                button: true,
                child: InkWell(
                  onTap: () => context.router.push(
                    MovieDetailRoute(
                      movieId: profile.favoriteMovies[index].id,
                      movieTitle: profile.favoriteMovies[index].title,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: posterColors[index],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          _SectionHeader(
            title: l10n?.profileRecentActivity ?? '',
            seeAllLabel: l10n?.profileSeeAll ?? '',
            onSeeAll: () {},
          ),
          const SizedBox(height: 12),
          ...List.generate(profile.recentActivities.length, (index) {
            final activity = profile.recentActivities[index];
            return Semantics(
              label: '${activity.action} ${activity.movie}, ${activity.time}',
              child: ExcludeSemantics(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Icon(
                        _activityIcon(activity.action),
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface,
                            ),
                            children: [
                              TextSpan(text: '${activity.action} '),
                              TextSpan(
                                text: activity.movie,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        activity.time,
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 28),
          _SectionHeader(
            title: l10n?.profileWatchlistSection ?? '',
            seeAllLabel: l10n?.profileSeeAll ?? '',
            onSeeAll: () => context.router.push(
              WatchListRoute(
                userId: profile.id,
                userName: profile.displayName,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: profile.watchlist.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Semantics(
                label: profile.watchlist[index].title,
                button: true,
                child: InkWell(
                  onTap: () => context.router.push(
                    MovieDetailRoute(
                      movieId: profile.watchlist[index].id,
                      movieTitle: profile.watchlist[index].title,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: posterColors[index],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  static IconData _activityIcon(String action) => switch (action) {
        'Watched' => Icons.visibility,
        'Reviewed' => Icons.rate_review,
        'Added to watchlist' => Icons.bookmark_add,
        'Liked review of' => Icons.favorite,
        _ => Icons.movie,
      };
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String seeAllLabel;
  final VoidCallback onSeeAll;

  const _SectionHeader({
    required this.title,
    required this.seeAllLabel,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme.titleSmall?.copyWith(color: colorScheme.onSurface),
        ),
        Semantics(
          button: true,
          label: '$seeAllLabel $title',
          child: GestureDetector(
            onTap: onSeeAll,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                seeAllLabel,
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondaryContainer,
          ),
        ),
        Text(
          label,
          style:
              textTheme.labelSmall?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
