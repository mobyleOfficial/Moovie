import 'package:flutter/material.dart';

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  static const _entries = [
    (title: 'Dune: Part Two', date: 'Mar 15, 2024', rating: 4.5),
    (title: 'Oppenheimer', date: 'Mar 10, 2024', rating: 5.0),
    (title: 'Poor Things', date: 'Mar 5, 2024', rating: 4.0),
    (title: 'The Zone of Interest', date: 'Feb 28, 2024', rating: 3.5),
    (title: 'Society of the Snow', date: 'Feb 20, 2024', rating: 4.0),
    (title: 'Past Lives', date: 'Feb 14, 2024', rating: 4.5),
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
      itemCount: _entries.length,
      separatorBuilder: (_, __) => Divider(
        indent: 72,
        height: 1,
        color: colorScheme.outlineVariant,
      ),
      itemBuilder: (context, index) => _DiaryEntryTile(
        title: _entries[index].title,
        date: _entries[index].date,
        rating: _entries[index].rating,
        posterColor: posterColors[index],
      ),
    );
  }
}

class _DiaryEntryTile extends StatelessWidget {
  final String title;
  final String date;
  final double rating;
  final Color posterColor;

  const _DiaryEntryTile({
    required this.title,
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
      label: '$title, $date, $ratingLabel',
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
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
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      date,
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
    );
  }
}
