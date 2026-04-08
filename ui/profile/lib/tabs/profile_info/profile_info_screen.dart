import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  static const _recentMovies = [
    (title: 'Dune: Part Two', id: 693134),
    (title: 'Oppenheimer', id: 872585),
    (title: 'Poor Things', id: 792307),
    (title: 'The Zone of Interest', id: 929590),
    (title: 'Society of the Snow', id: 876969),
  ];

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
            label: l10n?.profile ?? '',
            image: true,
            child: CircleAvatar(
              radius: 52,
              backgroundColor: colorScheme.secondaryContainer,
              child: ExcludeSemantics(
                child: Icon(
                  Icons.person,
                  size: 52,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '@filmfan42',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Movie lover & critic',
            style: textTheme.bodyMedium
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          Semantics(
            label:
                '248 ${l10n?.profileMoviesWatched ?? ''}, 32 ${l10n?.profileFollowing ?? ''}, 156 ${l10n?.profileFollowers ?? ''}',
            excludeSemantics: true,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ProfileStat(value: '248', label: l10n?.profileMoviesWatched ?? ''),
                  VerticalDivider(
                      color: colorScheme.outlineVariant, width: 1),
                  _ProfileStat(value: '32', label: l10n?.profileFollowing ?? ''),
                  VerticalDivider(
                      color: colorScheme.outlineVariant, width: 1),
                  _ProfileStat(value: '156', label: l10n?.profileFollowers ?? ''),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
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
          style: textTheme.labelSmall
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
