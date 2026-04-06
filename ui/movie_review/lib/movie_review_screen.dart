import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_review/movie_review_bloc.dart';
import 'package:movie_review/movie_review_state.dart';

class MovieReviewScreen extends StatefulWidget {
  final MovieReviewCubit cubit;
  final String movieTitle;
  final String posterPath;

  const MovieReviewScreen({
    super.key,
    required this.cubit,
    required this.movieTitle,
    required this.posterPath,
  });

  @override
  State<MovieReviewScreen> createState() => _MovieReviewScreenState();
}

class _MovieReviewScreenState extends State<MovieReviewScreen> {
  final TextEditingController _reviewNameController = TextEditingController();

  static const String _posterBaseUrl = 'https://image.tmdb.org/t/p/w185';

  @override
  void dispose() {
    _reviewNameController.dispose();
    super.dispose();
  }

  List<String> _buildTags(AppLocalizations l10n) => [
        l10n.movieReviewTagMasterpiece,
        l10n.movieReviewTagOverrated,
        l10n.movieReviewTagUnderrated,
        l10n.movieReviewTagMustWatch,
        l10n.movieReviewTagDisappointing,
        l10n.movieReviewTagFeelGood,
        l10n.movieReviewTagMindBending,
        l10n.movieReviewTagEmotional,
      ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocProvider.value(
      value: widget.cubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: Text(l10n.movieReviewTitle),
          actions: [
            Tooltip(
              message: l10n.movieReviewSend,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send),
              ),
            ),
          ],
        ),
        body: BlocBuilder<MovieReviewCubit, MovieReviewState>(
          builder: (context, state) => switch (state) {
            MovieReviewLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            MovieReviewError(:final message) => Center(
                child: Text(message),
              ),
            MovieReviewReady() => _ReviewBody(
                state: state,
                movieTitle: widget.movieTitle,
                posterPath: widget.posterPath,
                posterBaseUrl: _posterBaseUrl,
                reviewNameController: _reviewNameController,
                tags: _buildTags(l10n),
                l10n: l10n,
              ),
          },
        ),
      ),
    );
  }
}

class _ReviewBody extends StatelessWidget {
  final MovieReviewReady state;
  final String movieTitle;
  final String posterPath;
  final String posterBaseUrl;
  final TextEditingController reviewNameController;
  final List<String> tags;
  final AppLocalizations l10n;

  const _ReviewBody({
    required this.state,
    required this.movieTitle,
    required this.posterPath,
    required this.posterBaseUrl,
    required this.reviewNameController,
    required this.tags,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<MovieReviewCubit>();

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
            decoration: InputDecoration(
              hintText: l10n.movieReviewNameHint,
              border: const OutlineInputBorder(),
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
          const SizedBox(height: 24),
          Semantics(
            label: l10n.movieReviewAddReview,
            button: true,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(12),
              child: ExcludeSemantics(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.rate_review_outlined,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.movieReviewAddReview,
                        style: textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Tooltip(
                message: state.isRewatch
                    ? l10n.movieReviewRewatch
                    : l10n.movieReviewFirstTime,
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
                    ? l10n.movieReviewRewatch
                    : l10n.movieReviewFirstTime,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            l10n.movieReviewTags,
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
        ],
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
