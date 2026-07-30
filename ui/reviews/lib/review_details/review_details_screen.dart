import 'package:auto_route/auto_route.dart';
import 'package:comments_ui/comments_screen.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:public_profile/public_profile_router.dart';
import 'package:reviews/review_details/review_details_bloc.dart';
import 'package:reviews/review_details/review_details_router.dart';
import 'package:reviews/review_details/review_details_state.dart';

class ReviewDetailsScreen extends StatefulWidget {
  final ReviewDetailsCubit cubit;

  const ReviewDetailsScreen({super.key, required this.cubit});

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  AppBarController? _appBarController;
  bool _actionsRegistered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appBarController = AppBarControllerScope.of(context);
    if (!_actionsRegistered && _appBarController != null) {
      _actionsRegistered = true;
      final controller = _appBarController!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        controller.setActions([
          _ReviewDetailsActions(cubit: widget.cubit),
        ]);
      });
    }
  }

  @override
  void dispose() {
    final controller = _appBarController;
    if (controller != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.clearActions();
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocConsumer<ReviewDetailsCubit, ReviewDetailsState>(
        listener: (context, state) {
          if (state is ReviewDetailsLikeFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n?.reviewDetailsLikeError ?? '')),
            );
          }
        },
        buildWhen: (previous, current) => current is! ReviewDetailsLikeFailed,
        builder: (context, state) => switch (state) {
          ReviewDetailsLoading() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          ReviewDetailsError() => Scaffold(
              body: MuuvieEmptyState(
                title: l10n?.emptyStateErrorTitle ?? '',
                message: state.message,
                action: widget.cubit.reload,
                actionLabel: l10n?.emptyStateRetry ?? '',
              ),
            ),
          ReviewDetailsSuccess() => _ReviewDetailsSuccessView(state: state),
          // Should be filtered by buildWhen, but provide a fallback for safety.
          ReviewDetailsLikeFailed() =>
            _ReviewDetailsSuccessView(state: state.base),
        },
      ),
    );
  }
}

class _ReviewDetailsSuccessView extends StatelessWidget {
  final ReviewDetailsSuccess state;

  const _ReviewDetailsSuccessView({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<ReviewDetailsCubit>();
    final review = state.review;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MovieHeader(review: review),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RatingAndDateRow(review: review),
                  const SizedBox(height: 12),
                  if (review.authorId != null && review.author != null)
                    _AuthorRow(review: review),
                  const SizedBox(height: 16),
                  _LikeCountRow(count: review.likeCount),
                  const SizedBox(height: 24),
                  Text(
                    review.content ?? l10n?.reviewDetailsNoBody ?? '',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            CommentsScreen(contentId: review.id),
            const SizedBox(height: 16),
            _OtherReviewsSection(
              data: state.otherReviewsForMovie,
              onRetry: cubit.retryOtherReviewsForMovie,
            ),
            const SizedBox(height: 16),
            _MoreFromAuthorSection(
              authorName: review.author,
              data: state.moreFromAuthor,
              onRetry: cubit.retryMoreFromAuthor,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _ReviewDetailsActions extends StatelessWidget {
  final ReviewDetailsCubit cubit;

  const _ReviewDetailsActions({required this.cubit});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final shareService = GetIt.I<ShareService>();
    return BlocBuilder<ReviewDetailsCubit, ReviewDetailsState>(
      bloc: cubit,
      builder: (context, state) {
        final review = switch (state) {
          ReviewDetailsSuccess() => state.review,
          ReviewDetailsLikeFailed() => state.base.review,
          _ => null,
        };
        final isBusy = switch (state) {
          ReviewDetailsSuccess() => state.isLikeBusy,
          ReviewDetailsLikeFailed() => state.base.isLikeBusy,
          _ => false,
        };
        if (review == null) return const SizedBox.shrink();
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _LikeButton(
              isLiked: review.likedByCurrentUser,
              isBusy: isBusy,
              onPressed: () async {
                final allowed = await AuthGate.check(context);
                if (allowed) cubit.toggleLike();
              },
            ),
            Tooltip(
              message: l10n?.reviewDetailsShare ?? '',
              child: IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => shareService.shareReview(review),
                tooltip: l10n?.reviewDetailsShare,
                constraints: const BoxConstraints(
                  minWidth: 48,
                  minHeight: 48,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LikeButton extends StatelessWidget {
  final bool isLiked;
  final bool isBusy;
  final VoidCallback onPressed;

  const _LikeButton({
    required this.isLiked,
    required this.isBusy,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label =
        isLiked ? (l10n?.reviewDetailsUnlike ?? '') : (l10n?.reviewDetailsLike ?? '');
    return Semantics(
      button: true,
      label: label,
      child: Tooltip(
        message: label,
        child: IconButton(
          icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
          onPressed: isBusy ? null : onPressed,
          tooltip: label,
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        ),
      ),
    );
  }
}

class _MovieHeader extends StatelessWidget {
  final MovieReview review;

  const _MovieHeader({required this.review});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      button: true,
      label: review.title,
      child: InkWell(
        onTap: () => context.router.push(
          MovieDetailRoute(movieId: review.movieId, movieTitle: review.title),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExcludeSemantics(
                child: Container(
                  width: double.infinity,
                  height: 220,
                  color: colorScheme.tertiaryContainer,
                  child: Center(
                    child: Icon(
                      Icons.movie_outlined,
                      size: 64,
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  review.title,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatingAndDateRow extends StatelessWidget {
  final MovieReview review;

  const _RatingAndDateRow({required this.review});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        MuuvieStarRating(rating: review.rating, starSize: 18),
        const SizedBox(width: 10),
        Text(
          review.date,
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _AuthorRow extends StatelessWidget {
  final MovieReview review;

  const _AuthorRow({required this.review});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final authorId = review.authorId;
    final author = review.author ?? '';

    return Semantics(
      button: true,
      label: author,
      child: InkWell(
        onTap: authorId == null
            ? null
            : () => context.router.push(PublicProfileRoute(userId: authorId)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    author.isNotEmpty ? author.substring(0, 1).toUpperCase() : '?',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    author,
                    style: textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
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

class _LikeCountRow extends StatelessWidget {
  final int count;

  const _LikeCountRow({required this.count});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Icon(
          Icons.favorite_outline,
          size: 18,
          color: colorScheme.onSurfaceVariant,
          semanticLabel: null,
        ),
        const SizedBox(width: 8),
        Text(
          l10n?.reviewDetailsLikeCount(count) ?? '',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _OtherReviewsSection extends StatelessWidget {
  final Result<List<MovieReview>>? data;
  final Future<void> Function() onRetry;

  const _OtherReviewsSection({required this.data, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (data == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return switch (data!) {
      Failure() => _InlineRetryRow(
          message: l10n?.reviewDetailsLoadRelatedError ?? '',
          onRetry: onRetry,
        ),
      Success(:final data) => data.isEmpty
          ? const SizedBox.shrink()
          : _ReviewsCarousel(
              title: l10n?.reviewDetailsOtherReviewsForMovie ?? '',
              reviews: data,
              cardKind: _CarouselCardKind.byAuthor,
            ),
    };
  }
}

class _MoreFromAuthorSection extends StatelessWidget {
  final String? authorName;
  final Result<List<MovieReview>>? data;
  final Future<void> Function() onRetry;

  const _MoreFromAuthorSection({
    required this.authorName,
    required this.data,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (data == null) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return switch (data!) {
      Failure() => _InlineRetryRow(
          message: l10n?.reviewDetailsLoadRelatedError ?? '',
          onRetry: onRetry,
        ),
      Success(:final data) => data.isEmpty
          ? const SizedBox.shrink()
          : _ReviewsCarousel(
              title: l10n?.reviewDetailsMoreFromAuthor(
                    authorName ?? l10n.reviewDetailsAnonymousAuthor,
                  ) ??
                  '',
              reviews: data,
              cardKind: _CarouselCardKind.byMovie,
            ),
    };
  }
}

enum _CarouselCardKind {
  /// Card shows star rating + author (used in "other reviews for this movie").
  byAuthor,

  /// Card shows movie title + rating + date (used in "more from author").
  byMovie,
}

class _ReviewsCarousel extends StatelessWidget {
  final String title;
  final List<MovieReview> reviews;
  final _CarouselCardKind cardKind;

  const _ReviewsCarousel({
    required this.title,
    required this.reviews,
    required this.cardKind,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: reviews.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _CarouselCard(
              review: reviews[index],
              kind: cardKind,
            ),
          ),
        ),
      ],
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final MovieReview review;
  final _CarouselCardKind kind;

  const _CarouselCard({required this.review, required this.kind});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final author = review.author ?? l10n?.reviewDetailsAnonymousAuthor ?? '';
    return Semantics(
      button: true,
      label: kind == _CarouselCardKind.byMovie
          ? '${review.title}, ${review.date}'
          : '${review.title}, $author',
      child: SizedBox(
        width: 220,
        child: InkWell(
          onTap: () => context.router.push(
            ReviewDetailsRoute(reviewId: review.id, movieTitle: review.title),
          ),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MuuvieStarRating(rating: review.rating, starSize: 14),
                const SizedBox(height: 8),
                if (kind == _CarouselCardKind.byMovie)
                  Text(
                    review.title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                else
                  Text(
                    l10n?.reviewDetailsBy(author) ?? '',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(
                    kind == _CarouselCardKind.byMovie
                        ? review.date
                        : (review.content ?? ''),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

class _InlineRetryRow extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _InlineRetryRow({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(l10n?.emptyStateRetry ?? ''),
          ),
        ],
      ),
    );
  }
}
