import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/tabs/watchlist/watchlist_bloc.dart';
import 'package:profile_ui/tabs/watchlist/watchlist_state.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  WatchlistCubit? _cubit;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserAndInit();
  }

  Future<void> _loadUserAndInit() async {
    final result = await GetIt.I<GetUserProfile>()();
    if (!mounted) return;

    setState(() {
      _loading = false;
      if (result is Success<UserProfile>) {
        _cubit = WatchlistCubit(
          getUserWatchList: GetIt.I<GetUserWatchList>(),
          userId: result.data.id,
        );
      }
    });
  }

  @override
  void dispose() {
    _cubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final cubit = _cubit;
    if (cubit == null) {
      return MuuvieEmptyState(
        title: l10n?.emptyStateErrorTitle ?? '',
        message: l10n?.emptyStateErrorMessage ?? '',
      );
    }

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) => switch (state) {
          WatchlistLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          WatchlistError(:final message) => MuuvieEmptyState(
              title: l10n?.emptyStateErrorTitle ?? '',
              message: message,
            ),
          WatchlistSuccess() => PagingListener(
              controller: cubit.pagingController,
              builder: (context, pagingState, fetchNextPage) =>
                  PagedGridView<int, Movie>(
                state: pagingState,
                fetchNextPage: fetchNextPage,
                padding: const EdgeInsets.symmetric(
                  horizontal: muuvieGridPadding,
                  vertical: muuvieGridPadding,
                ),
                gridDelegate: muuvieGridDelegate,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  itemBuilder: (context, movie, index) =>
                      MuuvieMoviePosterCard(
                    imageUrl: movie.posterPath.isNotEmpty
                        ? '${TmdbImageUrl.posterLarge}${movie.posterPath}'
                        : null,
                    onTap: () => context.router.push(
                      MovieDetailRoute(
                        movieId: movie.id,
                        movieTitle: movie.title,
                      ),
                    ),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  firstPageErrorIndicatorBuilder: (_) => MuuvieEmptyState(
                    title: l10n?.emptyStateErrorTitle ?? '',
                    message: l10n?.emptyStateErrorMessage ?? '',
                    action: fetchNextPage,
                    actionLabel: l10n?.emptyStateRetry ?? '',
                  ),
                  noItemsFoundIndicatorBuilder: (_) => MuuvieEmptyState(
                    title: l10n?.emptyStateNoItemsTitle ?? '',
                    message: l10n?.emptyStateNoItemsMessage ?? '',
                  ),
                ),
              ),
            ),
        },
      ),
    );
  }
}
