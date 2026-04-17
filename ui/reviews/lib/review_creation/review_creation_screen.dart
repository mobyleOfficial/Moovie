import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviews/review_creation/review_creation_bloc.dart';
import 'package:reviews/review_creation/review_creation_state.dart';

class ReviewCreationScreen extends StatefulWidget {
  final ReviewCreationCubit cubit;
  final String movieTitle;
  final String posterPath;

  const ReviewCreationScreen({
    super.key,
    required this.cubit,
    required this.movieTitle,
    required this.posterPath,
  });

  @override
  State<ReviewCreationScreen> createState() => _ReviewCreationScreenState();
}

class _ReviewCreationScreenState extends State<ReviewCreationScreen> {
  late final TextEditingController _reviewNameController =
      TextEditingController(text: widget.cubit.initialDraft?.reviewTitle);


  @override
  void dispose() {
    _reviewNameController.dispose();
    super.dispose();
  }

  Future<void> _showSubmitDialog() async {
    if (!widget.cubit.validate()) return;

    final l10n = AppLocalizations.of(context);
    var confirmed = false;
    await MoovieDialog.show(
      context: context,
      title: l10n?.submitReviewTitle ?? 'Submit Review',
      content: l10n?.submitReviewContent ??
          'Are you sure you want to submit this review?',
      confirmText: l10n?.submit ?? 'Submit',
      cancelText: l10n?.cancel ?? 'Cancel',
      onConfirm: () => confirmed = true,
    );

    if (confirmed && mounted) {
      widget.cubit.submitReview();
      context.router.root.popUntilRoot();
    }
  }

  Future<void> _openReviewEditor(String? currentBody) async {
    final result = await MoovieReviewEditor.show(
      context,
      initialHtml: currentBody,
    );

    if (!mounted) return;

    widget.cubit.updateReviewBody(result);
  }

  List<String> _buildTags(AppLocalizations? l10n) => [
        l10n?.movieReviewTagMasterpiece ?? '',
        l10n?.movieReviewTagOverrated ?? '',
        l10n?.movieReviewTagUnderrated ?? '',
        l10n?.movieReviewTagMustWatch ?? '',
        l10n?.movieReviewTagDisappointing ?? '',
        l10n?.movieReviewTagFeelGood ?? '',
        l10n?.movieReviewTagMindBending ?? '',
        l10n?.movieReviewTagEmotional ?? '',
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider.value(
        value: widget.cubit,
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(l10n?.movieReviewTitle ?? ''),
          actions: [
            Tooltip(
              message: l10n?.movieReviewSend ?? '',
              child: IconButton(
                onPressed: _showSubmitDialog,
                icon: const Icon(Icons.send),
              ),
            ),
          ],
        ),
        body: BlocBuilder<ReviewCreationCubit, ReviewCreationState>(
          builder: (context, state) => switch (state) {
            ReviewCreationLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            ReviewCreationError(:final message) => MoovieEmptyState(
                title: l10n?.emptyStateErrorTitle ?? '',
                message: message,
                action: widget.cubit.reload,
                actionLabel: l10n?.emptyStateRetry ?? '',
              ),
            ReviewCreationReady() => _ReviewBody(
                state: state,
                movieTitle: widget.movieTitle,
                posterPath: widget.posterPath,
                posterBaseUrl: TmdbImageUrl.posterMedium,
                reviewNameController: _reviewNameController,
                tags: _buildTags(l10n),
                l10n: l10n,
                onAddReview: () =>
                    _openReviewEditor(state.reviewBody.isEmpty ? null : state.reviewBody),
              ),
          },
        ),
        ),
      ),
    );
  }
}

class _ReviewBody extends StatelessWidget {
  final ReviewCreationReady state;
  final String movieTitle;
  final String posterPath;
  final String posterBaseUrl;
  final TextEditingController reviewNameController;
  final List<String> tags;
  final AppLocalizations? l10n;
  final VoidCallback onAddReview;

  const _ReviewBody({
    required this.state,
    required this.movieTitle,
    required this.posterPath,
    required this.posterBaseUrl,
    required this.reviewNameController,
    required this.tags,
    required this.l10n,
    required this.onAddReview,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<ReviewCreationCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MovieHeader(
            movieTitle: movieTitle,
            posterPath: posterPath,
            posterBaseUrl: posterBaseUrl,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: reviewNameController,
            onChanged: cubit.updateReviewTitle,
            decoration: InputDecoration(
              hintText: l10n?.movieReviewNameHint ?? '',
              border: const OutlineInputBorder(),
              errorText: state.hasTitleError
                  ? (l10n?.fieldRequired ?? '')
                  : null,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              MoovieStarRating(
                rating: state.rating,
                onRatingChanged: cubit.updateRating,
              ),
              const Spacer(),
              Tooltip(
                message: state.isFavorite ? 'Remove from favorites' : 'Add to favorites',
                child: IconButton(
                  onPressed: cubit.toggleFavorite,
                  icon: Icon(
                    state.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: state.isFavorite
                        ? colorScheme.error
                        : colorScheme.onSurfaceVariant,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
          if (state.hasRatingError)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n?.ratingRequired ?? '',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ),
          const SizedBox(height: 24),
          _AddReviewSection(
            html: state.reviewBody.isEmpty ? null : state.reviewBody,
            onTap: onAddReview,
            hasError: state.hasBodyError,
          ),
          if (state.hasBodyError)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n?.reviewBodyRequired ?? '',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ),
          const SizedBox(height: 24),
          Row(
            children: [
              Tooltip(
                message: state.isRewatch
                    ? (l10n?.movieReviewRewatch ?? '')
                    : (l10n?.movieReviewFirstTime ?? ''),
                child: IconButton(
                  onPressed: cubit.toggleRewatch,
                  icon: Icon(
                    state.isRewatch ? Icons.replay : Icons.visibility,
                    color: state.isRewatch
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                state.isRewatch
                    ? (l10n?.movieReviewRewatch ?? '')
                    : (l10n?.movieReviewFirstTime ?? ''),
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n?.movieReviewTags ?? '',
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags
                .map(
                  (tag) => MoovieTag(
                    label: tag,
                    selected: state.selectedTags.contains(tag),
                    onTap: () => cubit.toggleTag(tag),
                  ),
                )
                .toList(),
          ),
          if (state.hasTagsError)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l10n?.tagsRequired ?? '',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AddReviewSection extends StatelessWidget {
  final String? html;
  final VoidCallback onTap;
  final bool hasError;

  const _AddReviewSection({
    required this.html,
    required this.onTap,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final hasContent = html != null && html!.isNotEmpty;

    return Semantics(
      label: hasContent ? 'Edit your review' : l10n?.movieReviewAddReview ?? '',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: hasContent
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                : null,
            border: Border.all(
              color: hasError ? colorScheme.error : colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: hasContent
              ? MoovieHtmlPreview(html: html!)
              : Row(
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l10n?.movieReviewAddReview ?? '',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _MovieHeader extends StatelessWidget {
  final String movieTitle;
  final String posterPath;
  final String posterBaseUrl;

  const _MovieHeader({
    required this.movieTitle,
    required this.posterPath,
    required this.posterBaseUrl,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: 80,
            height: 120,
            child: posterPath.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: '$posterBaseUrl$posterPath',
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: colorScheme.surfaceContainerHighest,
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.movie,
                        size: 32,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  )
                : Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.movie,
                      size: 32,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              movieTitle,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
