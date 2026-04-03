import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviews/review_details/review_details_router.dart';
import 'package:reviews/reviews_list/reviews_bloc.dart';
import 'package:reviews/reviews_list/reviews_state.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final ReviewsCubit _cubit = ReviewsCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: _cubit,
        child: BlocBuilder<ReviewsCubit, ReviewsState>(
          builder: (context, state) => switch (state) {
            ReviewsLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ReviewsError() => Center(child: Text(state.message)),
            ReviewsSuccess() => const _ReviewsList(),
          },
        ),
      );
}

class _ReviewsList extends StatelessWidget {
  const _ReviewsList();

  static const _reviews = [
    (
      title: 'Dune: Part Two',
      date: 'Mar 15, 2024',
      rating: 4.5,
    ),
    (
      title: 'Oppenheimer',
      date: 'Mar 10, 2024',
      rating: 5.0,
    ),
    (
      title: 'Poor Things',
      date: 'Mar 5, 2024',
      rating: 4.0,
    ),
    (
      title: 'The Zone of Interest',
      date: 'Feb 28, 2024',
      rating: 3.5,
    ),
    (
      title: 'Society of the Snow',
      date: 'Feb 20, 2024',
      rating: 4.0,
    ),
    (
      title: 'Past Lives',
      date: 'Feb 14, 2024',
      rating: 4.5,
    ),
    (
      title: 'Anatomy of a Fall',
      date: 'Feb 10, 2024',
      rating: 4.0,
    ),
    (
      title: 'The Holdovers',
      date: 'Feb 5, 2024',
      rating: 4.5,
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
      colorScheme.primaryContainer,
      colorScheme.tertiaryContainer,
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _reviews.length,
      separatorBuilder: (_, __) => Divider(
        indent: 72,
        height: 1,
        color: colorScheme.outlineVariant,
      ),
      itemBuilder: (context, index) => _ReviewTile(
        title: _reviews[index].title,
        date: _reviews[index].date,
        rating: _reviews[index].rating,
        posterColor: posterColors[index],
        posterColorIndex: index,
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final String title;
  final String date;
  final double rating;
  final Color posterColor;
  final int posterColorIndex;

  const _ReviewTile({
    required this.title,
    required this.date,
    required this.rating,
    required this.posterColor,
    required this.posterColorIndex,
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
      button: true,
      child: InkWell(
        onTap: () => context.router.push(
          ReviewDetailsRoute(
            movieTitle: title,
            reviewDate: date,
            rating: rating,
            posterColorIndex: posterColorIndex,
          ),
        ),
        child: ExcludeSemantics(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                : (isFilled
                                    ? Icons.star
                                    : Icons.star_border),
                            size: 14,
                            color: colorScheme.onTertiaryContainer,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  semanticLabel: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
