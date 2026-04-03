import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_detail/movie_detail_router.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  static const _movies = [
    (title: 'Dune: Part Three', id: 895538),
    (title: 'A Quiet Place: Day One', id: 762441),
    (title: 'Kingdom of the Planet of the Apes', id: 653346),
    (title: 'Furiosa', id: 786892),
    (title: 'Inside Out 2', id: 1022789),
    (title: 'Alien: Romulus', id: 945961),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final posterColors = [
      colorScheme.tertiaryContainer,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.secondaryContainer,
      colorScheme.primaryContainer,
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _movies.length,
      itemBuilder: (context, index) => _WatchlistMovieTile(
        title: _movies[index].title,
        posterColor: posterColors[index],
        movieId: _movies[index].id,
      ),
    );
  }
}

class _WatchlistMovieTile extends StatelessWidget {
  final String title;
  final Color posterColor;
  final int movieId;

  const _WatchlistMovieTile({
    required this.title,
    required this.posterColor,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: title,
      button: true,
      child: InkWell(
        onTap: () =>
            context.router.root.push(MovieDetailRoute(movieId: movieId)),
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ExcludeSemantics(
                child: Container(
                  decoration: BoxDecoration(
                    color: posterColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            ExcludeSemantics(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
