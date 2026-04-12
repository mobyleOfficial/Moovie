import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_bloc.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_state.dart';

class MovieListDetailScreen extends StatefulWidget {
  final MovieListDetailCubit cubit;
  final List<String> posterPaths;
  final void Function(int movieId, String movieTitle) onMovieTap;


  const MovieListDetailScreen({
    super.key,
    required this.cubit,
    required this.posterPaths,
    required this.onMovieTap,
  });

  @override
  State<MovieListDetailScreen> createState() => _MovieListDetailScreenState();
}

class _MovieListDetailScreenState extends State<MovieListDetailScreen> {
  late final String? _headerPoster = widget.posterPaths.isNotEmpty
      ? widget.posterPaths[Random().nextInt(widget.posterPaths.length)]
      : null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider.value(
        value: widget.cubit,
        child: BlocBuilder<MovieListDetailCubit, MovieListDetailState>(
          builder: (context, state) => switch (state) {
            MovieListDetailLoading() => const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            MovieListDetailError(:final message) => Scaffold(
                body: MoovieEmptyState(
                  title: l10n?.emptyStateErrorTitle ?? '',
                  message: message,
                  action: widget.cubit.reload,
                  actionLabel: l10n?.emptyStateRetry ?? '',
                ),
              ),
            MovieListDetailSuccess() => _Content(
                state: state,
                cubit: widget.cubit,
                headerPoster: _headerPoster,
                onMovieTap: widget.onMovieTap,
              posterBaseUrl: TmdbImageUrl.posterLarge,
              headerBaseUrl: TmdbImageUrl.backdrop,
              ),
          },
        ),
      );
  }
}

class _Content extends StatefulWidget {
  final MovieListDetailSuccess state;
  final MovieListDetailCubit cubit;
  final String? headerPoster;
  final void Function(int movieId, String movieTitle) onMovieTap;
  final String posterBaseUrl;
  final String headerBaseUrl;

  const _Content({
    required this.state,
    required this.cubit,
    required this.headerPoster,
    required this.onMovieTap,
    required this.posterBaseUrl,
    required this.headerBaseUrl,
  });

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = widget.state.detail;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          MoovieTabBar(tabs: [
            l10n?.movieListDetailMoviesTab(detail.totalMovies) ?? '',
            l10n?.movieListDetailCommentsTab(detail.commentsCount) ?? '',
          ]),
          Expanded(
            child: TabBarView(
              children: [
                _MoviesTab(
                  state: widget.state,
                  cubit: widget.cubit,
                  headerPoster: widget.headerPoster,
                  onMovieTap: widget.onMovieTap,
                  posterBaseUrl: widget.posterBaseUrl,
                  headerBaseUrl: widget.headerBaseUrl,
                ),
                Center(
                  child: Text(
                    l10n?.movieListDetailCommentsPlaceholder ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviesTab extends StatelessWidget {
  final MovieListDetailSuccess state;
  final MovieListDetailCubit cubit;
  final String? headerPoster;
  final void Function(int movieId, String movieTitle) onMovieTap;
  final String posterBaseUrl;
  final String headerBaseUrl;

  const _MoviesTab({
    required this.state,
    required this.cubit,
    required this.headerPoster,
    required this.onMovieTap,
    required this.posterBaseUrl,
    required this.headerBaseUrl,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PagingListener(
        controller: cubit.pagingController,
        builder: (context, pagingState, fetchNextPage) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(
                detail: state.detail,
                headerPoster: headerPoster,
                headerBaseUrl: headerBaseUrl,
                isLiked: state.isLiked,
                likesCount: state.likesCount,
                onToggleLike: cubit.toggleLike,
              ),
            ),
            SliverToBoxAdapter(
              child: _ViewModeToggle(
                isGridView: state.isGridView,
                onToggle: cubit.toggleViewMode,
              ),
            ),
            if (state.isGridView)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: moovieGridPadding,
                ),
                sliver: PagedSliverGrid<int, Movie>(
                  state: pagingState,
                  fetchNextPage: fetchNextPage,
                  gridDelegate: moovieGridDelegate,
                  builderDelegate: PagedChildBuilderDelegate<Movie>(
                    itemBuilder: (context, movie, index) =>
                        _MovieGridItem(
                      movie: movie,
                      index: index,
                      posterBaseUrl: posterBaseUrl,
                      onTap: () => onMovieTap(movie.id, movie.title),
                    ),
                    firstPageProgressIndicatorBuilder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                    firstPageErrorIndicatorBuilder: (_) => MoovieEmptyState(
                      title: l10n?.emptyStateErrorTitle ?? '',
                      message: l10n?.emptyStateErrorMessage ?? '',
                      action: fetchNextPage,
                      actionLabel: l10n?.emptyStateRetry ?? '',
                    ),
                    noItemsFoundIndicatorBuilder: (_) => MoovieEmptyState(
                      title: l10n?.emptyStateNoItemsTitle ?? '',
                      message: l10n?.emptyStateNoItemsMessage ?? '',
                    ),
                    newPageProgressIndicatorBuilder: (_) => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              )
            else
              PagedSliverList<int, Movie>(
                state: pagingState,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  itemBuilder: (context, movie, index) => _MovieListItem(
                    movie: movie,
                    index: index,
                    posterBaseUrl: posterBaseUrl,
                    onTap: () => onMovieTap(movie.id, movie.title),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  firstPageErrorIndicatorBuilder: (_) => MoovieEmptyState(
                    title: l10n?.emptyStateErrorTitle ?? '',
                    message: l10n?.emptyStateErrorMessage ?? '',
                    action: fetchNextPage,
                    actionLabel: l10n?.emptyStateRetry ?? '',
                  ),
                  noItemsFoundIndicatorBuilder: (_) => MoovieEmptyState(
                    title: l10n?.emptyStateNoItemsTitle ?? '',
                    message: l10n?.emptyStateNoItemsMessage ?? '',
                  ),
                  newPageProgressIndicatorBuilder: (_) => const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
          ],
        ),
      );
  }
}

class _MovieGridItem extends StatelessWidget {
  final Movie movie;
  final int index;
  final String posterBaseUrl;
  final VoidCallback onTap;

  const _MovieGridItem({
    required this.movie,
    required this.index,
    required this.posterBaseUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: '${index + 1}. ${movie.title}',
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: ExcludeSemantics(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox.expand(
                  child: movie.posterPath.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: '$posterBaseUrl${movie.posterPath}',
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: const Center(child: Icon(Icons.movie)),
                        ),
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#${index + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
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

class _MovieListItem extends StatelessWidget {
  final Movie movie;
  final int index;
  final String posterBaseUrl;
  final VoidCallback onTap;

  static const _posterWidth = 50.0;
  static const _posterHeight = 75.0;

  const _MovieListItem({
    required this.movie,
    required this.index,
    required this.posterBaseUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      label: '${index + 1}. ${movie.title}',
      button: true,
      child: InkWell(
        onTap: onTap,
        child: ExcludeSemantics(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Text(
                    '${index + 1}',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: _posterWidth,
                    height: _posterHeight,
                    child: movie.posterPath.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: '$posterBaseUrl${movie.posterPath}',
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: colorScheme.surfaceContainerHighest,
                            child: const Center(child: Icon(Icons.movie)),
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
                        movie.title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (movie.releaseDate.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          movie.releaseDate,
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final MovieListDetail detail;
  final String? headerPoster;
  final String headerBaseUrl;
  final bool isLiked;
  final int likesCount;
  final VoidCallback onToggleLike;

  const _Header({
    required this.detail,
    required this.headerPoster,
    required this.headerBaseUrl,
    required this.isLiked,
    required this.likesCount,
    required this.onToggleLike,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerPoster != null)
          CachedNetworkImage(
            imageUrl: '$headerBaseUrl$headerPoster',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            placeholder: (_, _) => Container(
              height: 200,
              color: colorScheme.surfaceContainerHighest,
            ),
            errorWidget: (_, _, _) => Container(
              height: 200,
              color: colorScheme.surfaceContainerHighest,
              child: const Center(child: Icon(Icons.movie, size: 48)),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.description,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                detail.creator,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              if (detail.tags.isNotEmpty) ...[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: detail.tags
                      .map((tag) => MoovieTag(label: tag))
                      .toList(),
                ),
                const SizedBox(height: 16),
              ],
              Row(
                children: [
                  IconButton(
                    onPressed: onToggleLike,
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked
                          ? colorScheme.error
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '$likesCount',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}

class _ViewModeToggle extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onToggle;

  const _ViewModeToggle({
    required this.isGridView,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Tooltip(
            message: isGridView
                ? l10n?.movieListDetailShowListView
                : l10n?.movieListDetailShowGridView,
            child: IconButton(
              onPressed: onToggle,
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  isGridView ? Icons.view_list : Icons.grid_view,
                  key: ValueKey(isGridView),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}