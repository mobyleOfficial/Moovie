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

  static const String _posterBaseUrl = 'https://image.tmdb.org/t/p/w342';
  static const String _headerBaseUrl = 'https://image.tmdb.org/t/p/w780';

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
    return BlocProvider.value(
      value: widget.cubit,
      child: BlocBuilder<MovieListDetailCubit, MovieListDetailState>(
        builder: (context, state) => switch (state) {
          MovieListDetailLoading() => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          MovieListDetailError(:final message) => Scaffold(
              body: Center(child: Text(message)),
            ),
          MovieListDetailSuccess() => _Content(
              state: state,
              cubit: widget.cubit,
              headerPoster: _headerPoster,
              onMovieTap: widget.onMovieTap,
              posterBaseUrl: MovieListDetailScreen._posterBaseUrl,
              headerBaseUrl: MovieListDetailScreen._headerBaseUrl,
            ),
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = state.detail;

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
                  state: state,
                  cubit: cubit,
                  headerPoster: headerPoster,
                  onMovieTap: onMovieTap,
                  posterBaseUrl: posterBaseUrl,
                  headerBaseUrl: headerBaseUrl,
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

class _MoviesTab extends StatefulWidget {
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
  State<_MoviesTab> createState() => _MoviesTabState();
}

class _MoviesTabState extends State<_MoviesTab>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static const _animDuration = Duration(milliseconds: 450);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _animDuration,
    value: widget.state.isGridView ? 0.0 : 1.0,
  );

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutCubic,
  );

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _MoviesTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.isGridView != oldWidget.state.isGridView) {
      if (widget.state.isGridView) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final detail = widget.state.detail;

    return PagingListener(
      controller: widget.cubit.pagingController,
      builder: (context, pagingState, fetchNextPage) => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Header(
              detail: detail,
              headerPoster: widget.headerPoster,
              headerBaseUrl: widget.headerBaseUrl,
              isLiked: widget.state.isLiked,
              likesCount: widget.state.likesCount,
              onToggleLike: widget.cubit.toggleLike,
            ),
          ),
          SliverToBoxAdapter(
            child: _ViewModeToggle(
              isGridView: widget.state.isGridView,
              onToggle: widget.cubit.toggleViewMode,
            ),
          ),
          SliverLayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.crossAxisExtent;
              const gridPadding = moovieGridPadding;
              final gridAvailable = screenWidth - gridPadding * 2;
              const columns = moovieGridCrossAxisCount;
              final gridItemW = (gridAvailable -
                      moovieGridSpacing * (columns - 1)) /
                  columns;
              final gridItemH = gridItemW / moovieGridChildAspectRatio;

              return AnimatedBuilder(
                animation: _animation,
                builder: (context, _) {
                  final t = _animation.value;
                  final allItems = pagingState.pages
                          ?.expand((page) => page)
                          .toList() ??
                      <Movie>[];

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _lerpDouble(gridPadding, 0, t),
                    ),
                    sliver: PagedSliverList<int, Movie>(
                      state: pagingState,
                      fetchNextPage: fetchNextPage,
                      builderDelegate: PagedChildBuilderDelegate<Movie>(
                        itemBuilder: (context, movie, index) =>
                            _AnimatedMovieItem(
                          t: t,
                          movie: movie,
                          index: index,
                          allItems: allItems,
                          columns: columns,
                          gridItemWidth: gridItemW,
                          gridItemHeight: gridItemH,
                          gridSpacing: moovieGridSpacing,
                          screenWidth: screenWidth,
                          posterBaseUrl: widget.posterBaseUrl,
                          onTap: (m) =>
                              widget.onMovieTap(m.id, m.title),
                        ),
                        firstPageProgressIndicatorBuilder: (_) =>
                            const Center(
                                child: CircularProgressIndicator()),
                        newPageProgressIndicatorBuilder: (_) =>
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static double _lerpDouble(double a, double b, double t) => a + (b - a) * t;
}

class _AnimatedMovieItem extends StatelessWidget {
  final double t;
  final Movie movie;
  final int index;
  final List<Movie> allItems;
  final int columns;
  final double gridItemWidth;
  final double gridItemHeight;
  final double gridSpacing;
  final double screenWidth;
  final String posterBaseUrl;
  final void Function(Movie movie) onTap;

  static const _listHeight = 91.0;
  static const _listPosterWidth = 50.0;
  static const _listPosterHeight = 75.0;

  const _AnimatedMovieItem({
    required this.t,
    required this.movie,
    required this.index,
    required this.allItems,
    required this.columns,
    required this.gridItemWidth,
    required this.gridItemHeight,
    required this.gridSpacing,
    required this.screenWidth,
    required this.posterBaseUrl,
    required this.onTap,
  });

  double _lerp(double a, double b) => a + (b - a) * t;

  @override
  Widget build(BuildContext context) {
    final col = index % columns;
    final isFirstInRow = col == 0;

    // Non-first items in a row: in grid mode they are rendered by the
    // first item's Stack, so they contribute 0 layout height.
    // During animation they grow to full list height.
    if (!isFirstInRow) {
      final height = _lerp(0, _listHeight);
      if (height < 0.5) return const SizedBox.shrink();
      return SizedBox(
        height: height,
        child: _buildSingleItem(context, index, movie),
      );
    }

    // First item in a row: in grid mode it has full gridItemHeight
    // and renders all items in its row via a Stack.
    // In list mode it's just one list item.
    final row = index ~/ columns;
    final rowTopPad = row > 0 ? _lerp(gridSpacing, 0) : 0.0;

    // Collect sibling items in this grid row
    final rowItems = <Movie>[];
    for (int c = 0; c < columns; c++) {
      final i = index + c;
      if (i < allItems.length) {
        rowItems.add(allItems[i]);
      }
    }

    final height = _lerp(gridItemHeight, _listHeight);

    return Padding(
      padding: EdgeInsets.only(top: rowTopPad),
      child: SizedBox(
        height: height,
        child: t < 1.0
            ? _buildRowStack(context, rowItems)
            : _buildSingleItem(context, index, movie),
      ),
    );
  }

  Widget _buildRowStack(BuildContext context, List<Movie> rowItems) {
    final availableWidth = screenWidth;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (int c = 0; c < rowItems.length; c++)
          _buildPositionedGridItem(context, c, index + c, rowItems[c], availableWidth),
      ],
    );
  }

  Widget _buildPositionedGridItem(
    BuildContext context,
    int col,
    int itemIndex,
    Movie item,
    double availableWidth,
  ) {
    final gridLeft = col * (gridItemWidth + gridSpacing);
    final left = _lerp(gridLeft, 0);
    final width = _lerp(gridItemWidth, availableWidth);
    final posterWidth = _lerp(gridItemWidth, _listPosterWidth);
    final posterHeight = _lerp(gridItemHeight, _listPosterHeight);
    final borderRadius = _lerp(10, 8);

    final listElementsOpacity = Curves.easeIn.transform(
      (t - 0.5).clamp(0, 0.5) * 2,
    );
    final gridElementsOpacity = Curves.easeOut.transform(
      (1.0 - t * 2).clamp(0, 1),
    );

    // In grid, all items in the row sit at top: 0.
    // During transition, non-first items slide down.
    final top = col > 0 ? _lerp(0, col * _listHeight) : 0.0;

    return Positioned(
      left: left,
      top: top,
      width: width,
      height: _lerp(gridItemHeight, _listHeight),
      child: GestureDetector(
        onTap: () => onTap(item),
        child: _buildItemContent(
          context,
          itemIndex,
          item,
          posterWidth,
          posterHeight,
          borderRadius,
          listElementsOpacity,
          gridElementsOpacity,
        ),
      ),
    );
  }

  Widget _buildSingleItem(BuildContext context, int itemIndex, Movie item) {
    final listElementsOpacity = Curves.easeIn.transform(
      (t - 0.5).clamp(0, 0.5) * 2,
    );
    final gridElementsOpacity = Curves.easeOut.transform(
      (1.0 - t * 2).clamp(0, 1),
    );

    return GestureDetector(
      onTap: () => onTap(item),
      child: _buildItemContent(
        context,
        itemIndex,
        item,
        _listPosterWidth,
        _listPosterHeight,
        8,
        listElementsOpacity,
        gridElementsOpacity,
      ),
    );
  }

  Widget _buildItemContent(
    BuildContext context,
    int itemIndex,
    Movie item,
    double posterWidth,
    double posterHeight,
    double borderRadius,
    double listElementsOpacity,
    double gridElementsOpacity,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        if (listElementsOpacity > 0)
          Opacity(
            opacity: listElementsOpacity,
            child: SizedBox(
              width: _lerp(0, 40),
              child: Text(
                '${itemIndex + 1}',
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: SizedBox(
                width: posterWidth,
                height: posterHeight,
                child: item.posterPath.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: '$posterBaseUrl${item.posterPath}',
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: colorScheme.surfaceContainerHighest,
                        child: const Center(child: Icon(Icons.movie)),
                      ),
              ),
            ),
            if (gridElementsOpacity > 0)
              Positioned(
                top: 6,
                left: 6,
                child: Opacity(
                  opacity: gridElementsOpacity,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '#${itemIndex + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (listElementsOpacity > 0) ...[
          SizedBox(width: _lerp(0, 12)),
          Expanded(
            child: Opacity(
              opacity: listElementsOpacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.releaseDate.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.releaseDate,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Opacity(
            opacity: listElementsOpacity,
            child: Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
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
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Icon(
                isGridView ? Icons.view_list : Icons.grid_view,
                key: ValueKey(isGridView),
              ),
            ),
            tooltip: isGridView ? 'List view' : 'Grid view',
          ),
        ],
      ),
    );
  }
}
