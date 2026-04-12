import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';
import 'package:public_profile/user_review/user_reviews_bloc.dart';
import 'package:reviews/review_details/review_details_router.dart';

class UserReviewsScreen extends StatefulWidget {
  const UserReviewsScreen({super.key});

  @override
  State<UserReviewsScreen> createState() => _UserReviewsScreenState();
}

class _UserReviewsScreenState extends State<UserReviewsScreen> {
  late final UserReviewsCubit _cubit =
      UserReviewsCubit(GetIt.I<GetUserReviews>());

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: _cubit,
        child: const _UserReviewsPaginatedList(),
      );
}

class _UserReviewsPaginatedList extends StatelessWidget {
  const _UserReviewsPaginatedList();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserReviewsCubit>();
    final colorScheme = Theme.of(context).colorScheme;
    final posterColors = [
      colorScheme.tertiaryContainer,
      colorScheme.primaryContainer,
      colorScheme.secondaryContainer,
      colorScheme.surfaceContainerHighest,
    ];

    return PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) =>
          PagedListView<int, MovieReview>(
        state: pagingState,
        fetchNextPage: fetchNextPage,
        padding: const EdgeInsets.symmetric(vertical: 8),
        builderDelegate: PagedChildBuilderDelegate<MovieReview>(
          itemBuilder: (context, review, index) => Column(
            children: [
              if (index > 0)
                Divider(
                  indent: 72,
                  height: 1,
                  color: colorScheme.outlineVariant,
                ),
              _UserReviewTile(
                review: review,
                index: index,
                posterColor: posterColors[index % posterColors.length],
              ),
            ],
          ),
          firstPageProgressIndicatorBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          firstPageErrorIndicatorBuilder: (_) => Center(
            child: Text(AppLocalizations.of(context)?.unknownError ?? ''),
          ),
        ),
      ),
    );
  }
}

class _UserReviewTile extends StatelessWidget {
  final MovieReview review;
  final int index;
  final Color posterColor;

  const _UserReviewTile({
    required this.review,
    required this.index,
    required this.posterColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final ratingLabel = review.rating % 1 == 0
        ? '${review.rating.toInt()} out of 5 stars'
        : '${review.rating} out of 5 stars';

    return Semantics(
      label: '${review.title}, ${review.date}, $ratingLabel',
      button: true,
      child: InkWell(
        onTap: () => context.router.push(
          ReviewDetailsRoute(
            movieTitle: review.title,
            reviewDate: review.date,
            rating: review.rating,
            posterColorIndex: index % 4,
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
                        review.title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        review.date,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: List.generate(5, (starIndex) {
                          final isFilled =
                              starIndex < review.rating.floor();
                          final isHalf =
                              !isFilled && starIndex < review.rating;
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
