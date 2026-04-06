import 'package:flutter/material.dart';

class MoviesArticlesScreen extends StatelessWidget {
  const MoviesArticlesScreen({super.key});

  static const _articles = [
    (
      title: 'Why Dune: Part Two Is a Masterpiece of Sci-Fi Cinema',
      author: 'Alice Martins',
      date: 'Mar 15, 2024',
      rating: 5.0,
    ),
    (
      title: 'Oppenheimer and the Weight of History',
      author: 'Bruno Carvalho',
      date: 'Mar 10, 2024',
      rating: 4.5,
    ),
    (
      title: 'Poor Things: Yorgos Lanthimos at His Most Daring',
      author: 'Camila Torres',
      date: 'Mar 5, 2024',
      rating: 4.0,
    ),
    (
      title: 'Past Lives and the Grief of What Could Have Been',
      author: 'Diego Ferreira',
      date: 'Feb 28, 2024',
      rating: 4.5,
    ),
    (
      title: 'Society of the Snow: Survival as a Human Condition',
      author: 'Elena Souza',
      date: 'Feb 20, 2024',
      rating: 4.0,
    ),
    (
      title: 'The Zone of Interest: Horror Without Showing Horror',
      author: 'Felipe Lima',
      date: 'Feb 14, 2024',
      rating: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final posterColors = [
      colorScheme.tertiaryContainer,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.surfaceContainerHighest,
      colorScheme.tertiaryContainer,
      colorScheme.secondaryContainer,
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _articles.length,
      separatorBuilder: (_, __) => Divider(
        indent: 72,
        height: 1,
        color: colorScheme.outlineVariant,
      ),
      itemBuilder: (context, index) => _ArticleTile(
        title: _articles[index].title,
        author: _articles[index].author,
        date: _articles[index].date,
        rating: _articles[index].rating,
        posterColor: posterColors[index],
      ),
    );
  }
}

class _ArticleTile extends StatelessWidget {
  final String title;
  final String author;
  final String date;
  final double rating;
  final Color posterColor;

  const _ArticleTile({
    required this.title,
    required this.author,
    required this.date,
    required this.rating,
    required this.posterColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final ratingLabel = rating % 1 == 0
        ? '${rating.toInt()} out of 5 stars'
        : '$rating out of 5 stars';

    return Semantics(
      label: '$title by $author, $date, $ratingLabel',
      button: true,
      child: InkWell(
        onTap: () {},
        child: ExcludeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 64,
                  decoration: BoxDecoration(
                    color: posterColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$author · $date',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: List.generate(5, (starIndex) {
                          final isFilled = starIndex < rating.floor();
                          final isHalf = !isFilled && starIndex < rating;
                          return Icon(
                            isHalf
                                ? Icons.star_half
                                : (isFilled ? Icons.star : Icons.star_border),
                            size: 14,
                            color: colorScheme.onTertiaryContainer,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
