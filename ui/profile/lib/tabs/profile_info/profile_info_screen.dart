import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:profile/profile.dart';
import 'package:profile_ui/profile_router.dart';
import 'package:public_profile/public_profile_router.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  UserProfile? _profile;
  bool _loading = true;

  static const _recentMovies = [
    (title: 'Dune: Part Two', id: 693134),
    (title: 'Oppenheimer', id: 872585),
    (title: 'Poor Things', id: 792307),
    (title: 'The Zone of Interest', id: 929590),
    (title: 'Society of the Snow', id: 876969),
  ];

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final result = await GetIt.I<GetUserProfile>()();
    if (!mounted) return;
    setState(() {
      _loading = false;
      if (result is Success<UserProfile>) {
        _profile = result.data;
      }
    });
  }

  Future<void> _openEditProfile() async {
    final profile = _profile;
    if (profile == null) return;

    final result = await context.router.root.push<UserProfile?>(
      EditProfileRoute(
        initialPhotoUrl: profile.photoUrl,
        initialUsername: profile.username,
        initialBio: profile.bio,
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _profile = profile.copyWith(
          photoUrl: result.photoUrl,
          username: result.username,
          bio: result.bio,
        );
      });
    }
  }

  void _openMoviesWatchedSheet() {
    final profile = _profile;
    if (profile == null) return;
    final l10n = AppLocalizations.of(context);

    MoovieBottomSheet.show(
      context: context,
      builder: (_) => _MoviesListSheet(
        title: l10n?.profileMoviesWatchedTitle ?? '',
        emptyMessage: l10n?.profileEmptyMoviesWatched ?? '',
        movies: profile.moviesWatched,
      ),
    );
  }

  void _openFollowingSheet() {
    final profile = _profile;
    if (profile == null) return;
    final l10n = AppLocalizations.of(context);

    MoovieBottomSheet.show(
      context: context,
      builder: (_) => _UsersListSheet(
        title: l10n?.profileFollowingTitle ?? '',
        emptyMessage: l10n?.profileEmptyFollowing ?? '',
        users: profile.following,
      ),
    );
  }

  void _openFollowersSheet() {
    final profile = _profile;
    if (profile == null) return;
    final l10n = AppLocalizations.of(context);

    MoovieBottomSheet.show(
      context: context,
      builder: (_) => _UsersListSheet(
        title: l10n?.profileFollowersTitle ?? '',
        emptyMessage: l10n?.profileEmptyFollowers ?? '',
        users: profile.followers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final profile = _profile;
    if (profile == null) {
      return Center(
        child: Text(l10n?.unknownError ?? ''),
      );
    }

    final posterColors = [
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.primaryContainer,
    ];

    final moviesWatchedCount = profile.moviesWatched.length;
    final followingCount = profile.following.length;
    final followersCount = profile.followers.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Semantics(
            label: l10n?.profile ?? '',
            image: true,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: colorScheme.secondaryContainer,
              backgroundImage: profile.photoUrl.isNotEmpty
                  ? NetworkImage(profile.photoUrl)
                  : null,
              child: profile.photoUrl.isEmpty
                  ? ExcludeSemantics(
                      child: Icon(
                        Icons.person,
                        size: 52,
                        color: colorScheme.onSecondaryContainer,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            profile.username,
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
          ),
          const SizedBox(height: 24),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ProfileStat(
                  value: '$moviesWatchedCount',
                  label: l10n?.profileMoviesWatched ?? '',
                  onTap: _openMoviesWatchedSheet,
                ),
                VerticalDivider(color: colorScheme.outlineVariant, width: 1),
                _ProfileStat(
                  value: '$followingCount',
                  label: l10n?.profileFollowing ?? '',
                  onTap: _openFollowingSheet,
                ),
                VerticalDivider(color: colorScheme.outlineVariant, width: 1),
                _ProfileStat(
                  value: '$followersCount',
                  label: l10n?.profileFollowers ?? '',
                  onTap: _openFollowersSheet,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _openEditProfile,
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.onSecondaryContainer,
                side: BorderSide(color: colorScheme.onSecondaryContainer),
              ),
              child: Text(l10n?.profileEditProfile ?? ''),
            ),
          ),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n?.profileRecentMovies ?? '',
              style:
                  textTheme.titleSmall?.copyWith(color: colorScheme.onSurface),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _recentMovies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => Semantics(
                label: _recentMovies[index].title,
                button: true,
                child: InkWell(
                  onTap: () => context.router.push(
                    MovieDetailRoute(
                      movieId: _recentMovies[index].id,
                      movieTitle: _recentMovies[index].title,
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
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  final VoidCallback onTap;

  const _ProfileStat({
    required this.value,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '$value $label',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
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
                style: textTheme.labelSmall
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const _SheetScaffold({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      child: Material(
        color: colorScheme.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }
}

class _MoviesListSheet extends StatelessWidget {
  final String title;
  final String emptyMessage;
  final List<Movie> movies;

  const _MoviesListSheet({
    required this.title,
    required this.emptyMessage,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return _SheetScaffold(
      title: title,
      child: movies.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                emptyMessage,
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              shrinkWrap: true,
              itemCount: movies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(
                      MovieDetailRoute(
                        movieId: movie.id,
                        movieTitle: movie.title,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: movie.posterPath.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl:
                                    '${TmdbImageUrl.posterMedium}${movie.posterPath}',
                                width: 48,
                                height: 72,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  width: 48,
                                  height: 72,
                                  color: colorScheme.surfaceContainerHighest,
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  width: 48,
                                  height: 72,
                                  color: colorScheme.surfaceContainerHighest,
                                  child: Icon(
                                    Icons.movie,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              )
                            : Container(
                                width: 48,
                                height: 72,
                                color: colorScheme.surfaceContainerHighest,
                                child: Icon(
                                  Icons.movie,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          movie.title,
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class _UsersListSheet extends StatelessWidget {
  final String title;
  final String emptyMessage;
  final List<UserSummary> users;

  const _UsersListSheet({
    required this.title,
    required this.emptyMessage,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return _SheetScaffold(
      title: title,
      child: users.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                emptyMessage,
                style: textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              shrinkWrap: true,
              itemCount: users.length,
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.router.push(PublicProfileRoute(userId: user.id));
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundColor: colorScheme.secondaryContainer,
                    backgroundImage: user.photoUrl.isNotEmpty
                        ? NetworkImage(user.photoUrl)
                        : null,
                    child: user.photoUrl.isEmpty
                        ? Icon(
                            Icons.person,
                            color: colorScheme.onSecondaryContainer,
                          )
                        : null,
                  ),
                  title: Text(
                    user.username,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
