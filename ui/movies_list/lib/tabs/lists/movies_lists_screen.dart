import 'package:common/common.dart';
import 'package:flutter/material.dart';

class MoviesListsScreen extends StatelessWidget {
  const MoviesListsScreen({super.key});

  static const _lists = [
    (title: 'Best of 2024', count: 24),
    (title: 'Essential Sci-Fi', count: 18),
    (title: 'Weekend Picks', count: 12),
    (title: 'Must Watch Classics', count: 30),
    (title: 'Horror Gems', count: 15),
    (title: 'A24 Favorites', count: 22),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final coverColors = [
      colorScheme.primaryContainer,
      colorScheme.tertiaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.tertiaryContainer,
      colorScheme.primaryContainer,
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _lists.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _ListTile(
          title: _lists[index].title,
          movieCount: _lists[index].count,
          coverColor: coverColors[index],
          moviesLabel: l10n.profileMoviesWatched.toLowerCase(),
        ),
      ),
    );
  }
}

class _ListTile extends StatelessWidget {
  final String title;
  final int movieCount;
  final Color coverColor;
  final String moviesLabel;

  const _ListTile({
    required this.title,
    required this.movieCount,
    required this.coverColor,
    required this.moviesLabel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '$title, $movieCount $moviesLabel',
      button: true,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: ExcludeSemantics(
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: coverColor,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '$movieCount $moviesLabel',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  semanticLabel: '',
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
