import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_router.dart';
import 'package:movies_ui/tabs/lists/movies_list_tile.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/tabs/lists/user_movie_lists_bloc.dart';
import 'package:profile_ui/tabs/lists/user_movie_lists_state.dart';

class UserMovieListsScreen extends StatefulWidget {
  const UserMovieListsScreen({super.key});

  @override
  State<UserMovieListsScreen> createState() => _UserMovieListsScreenState();
}

class _UserMovieListsScreenState extends State<UserMovieListsScreen> {
  UserMovieListsCubit? _cubit;
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
        _cubit = UserMovieListsCubit(
          GetIt.I<GetMovieLists>(),
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
      child: BlocBuilder<UserMovieListsCubit, UserMovieListsState>(
        builder: (context, state) => switch (state) {
          UserMovieListsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          UserMovieListsError(:final message) => MuuvieEmptyState(
              title: l10n?.emptyStateErrorTitle ?? '',
              message: message,
            ),
          UserMovieListsSuccess() => PagingListener(
              controller: cubit.pagingController,
              builder: (context, pagingState, fetchNextPage) =>
                  PagedListView<int, MovieList>(
                state: pagingState,
                fetchNextPage: fetchNextPage,
                padding: const EdgeInsets.all(16),
                builderDelegate: PagedChildBuilderDelegate<MovieList>(
                  itemBuilder: (context, movieList, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: MoviesListTile(
                      title: movieList.name,
                      creator: movieList.creator,
                      description: movieList.description,
                      posterPaths: movieList.info?.posterPaths ?? const [],
                      onTap: () => context.router.push(
                        MovieListDetailRoute(
                          listId: movieList.id,
                          listName: movieList.name,
                          posterPaths: movieList.info?.posterPaths ?? const [],
                        ),
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
