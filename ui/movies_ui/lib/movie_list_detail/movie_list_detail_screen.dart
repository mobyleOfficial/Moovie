import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_bloc.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_state.dart';

class MovieListDetailScreen extends StatelessWidget {
  final MovieListDetailCubit cubit;
  final List<String> posterPaths;
  final void Function(int movieId, String movieTitle) onMovieTap;

  static const String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';
  static const String _headerBaseUrl = 'https://image.tmdb.org/t/p/w780';

  const MovieListDetailScreen({
    super.key,
    required this.cubit,
    required this.posterPaths,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<MovieListDetailCubit, MovieListDetailState>(
        builder: (context, state) => switch (state) {
          MovieListDetailLoading() =>
            const Center(child: CircularProgressIndicator()),
          MovieListDetailError(:final message) => Center(child: Text(message)),
          MovieListDetailSuccess() => _Content(
              state: state,
              cubit: cubit,
              posterPaths: posterPaths,
              onMovieTap: onMovieTap,
              posterBaseUrl: _posterBaseUrl,
              headerBaseUrl: _headerBaseUrl,
            ),
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final MovieListDetailSuccess state;
  final MovieListDetailCubit cubit;
  final List<String> posterPaths;
  final void Function(int movieId, String movieTitle) onMovieTap;
  final String posterBaseUrl;
  final String headerBaseUrl;

  const _Content({
    required this.state,
    required this.cubit,
    required this.posterPaths,
    required this.onMovieTap,
    required this.posterBaseUrl,
    required this.headerBaseUrl,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final detail = state.detail;

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          MoovieTabBar(tabs: [
            l10n.movieListDetailMoviesTab(detail.totalMovies),
            l10n.movieListDetailCommentsTab(detail.commentsCount),
          ]),
          Expanded(
            child: TabBarView(
              children: [
                _MoviesTab(
                  state: state,
                  cubit: cubit,
                  posterPaths: posterPaths,
                  onMovieTap: onMovieTap,
                  posterBaseUrl: posterBaseUrl,
                  headerBaseUrl: headerBaseUrl,
                ),
                Center(
                  child: Text(
                    l10n.movieListDetailCommentsPlaceholder,
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
  final List<String> posterPaths;
  final void Function(int movieId, String movieTitle) onMovieTap;
  final String posterBaseUrl;
  final String headerBaseUrl;

  const _MoviesTab({
    required this.state,
    required this.cubit,
    required this.posterPaths,
    required this.onMovieTap,
    required this.posterBaseUrl,
    required this.headerBaseUrl,
  });

  @override
  Widget build(BuildContext context) {
    final detail = state.detail;

    return PagingListener(
      controller: cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Header(
              detail: detail,
              posterPaths: posterPaths,
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
            PagedSliverGrid<int, Movie>(
              state: pagingState,
              fetchNextPage: fetchNextPage,
              gridDelegate: moovieGridDelegate,
              builderDelegate: PagedChildBuilderDelegate<Movie>(
                itemBuilder: (context, movie, index) =>
                    _GridMovieItem(
                      movie: movie,
                      index: index,
                      posterBaseUrl: posterBaseUrl,
                      onTap: () => onMovieTap(movie.id, movie.title),
                    ),
                firstPageProgressIndicatorBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            )
          else
            PagedSliverList<int, Movie>(
              state: pagingState,
              fetchNextPage: fetchNextPage,
              builderDelegate: PagedChildBuilderDelegate<Movie>(
                itemBuilder: (context, movie, index) =>
                    _ListMovieItem(
                      movie: movie,
                      index: index,
                      posterBaseUrl: posterBaseUrl,
                      onTap: () => onMovieTap(movie.id, movie.title),
                    ),
                firstPageProgressIndicatorBuilder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final MovieListDetail detail;
  final List<String> posterPaths;
  final String headerBaseUrl;
  final bool isLiked;
  final int likesCount;
  final VoidCallback onToggleLike;

  const _Header({
    required this.detail,
    required this.posterPaths,
    required this.headerBaseUrl,
    required this.isLiked,
    required this.likesCount,
    required this.onToggleLike,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final randomPoster = posterPaths.isNotEmpty
        ? posterPaths[Random().nextInt(posterPaths.length)]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (randomPoster != null)
          CachedNetworkImage(
            imageUrl: '$headerBaseUrl$randomPoster',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              height: 200,
              color: colorScheme.surfaceContainerHighest,
            ),
            errorWidget: (_, __, ___) => Container(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: onToggle,
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: isGridView ? 'List view' : 'Grid view',
          ),
        ],
      ),
    );
  }
}

class _GridMovieItem extends StatelessWidget {
  final Movie movie;
  final int index;
  final String posterBaseUrl;
  final VoidCallback onTap;

  const _GridMovieItem({
    required this.movie,
    required this.index,
    required this.posterBaseUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (movie.posterPath.isNotEmpty)
                Ink.image(
                  image: CachedNetworkImageProvider(
                    '$posterBaseUrl${movie.posterPath}',
                  ),
                  fit: BoxFit.cover,
                )
              else
                const Center(child: Icon(Icons.movie, size: 36)),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

class _ListMovieItem extends StatelessWidget {
  final Movie movie;
  final int index;
  final String posterBaseUrl;
  final VoidCallback onTap;

  const _ListMovieItem({
    required this.movie,
    required this.index,
    required this.posterBaseUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '${index + 1}',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: movie.posterPath.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: '$posterBaseUrl${movie.posterPath}',
                      width: 50,
                      height: 75,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 50,
                      height: 75,
                      color: colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.movie),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
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
    );
  }
}