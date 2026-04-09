import 'package:auto_route/auto_route.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_list_detail/movie_list_detail_router.dart';
import 'package:movies_ui/tabs/lists/movies_list_tile.dart';

import 'package:profile_ui/tabs/lists/user_movie_lists_bloc.dart';
import 'package:profile_ui/tabs/lists/user_movie_lists_state.dart';

class UserMovieListsScreen extends StatefulWidget {
  const UserMovieListsScreen({super.key});

  @override
  State<UserMovieListsScreen> createState() => _UserMovieListsScreenState();
}

class _UserMovieListsScreenState extends State<UserMovieListsScreen> {
  late final UserMovieListsCubit _cubit = UserMovieListsCubit(
    GetIt.I<GetUserMovieLists>(),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<UserMovieListsCubit, UserMovieListsState>(
        builder: (context, state) => switch (state) {
          UserMovieListsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          UserMovieListsError(:final message) => Center(
              child: Text(message),
            ),
          UserMovieListsSuccess() => PagingListener(
              controller: _cubit.pagingController,
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
                      posterPaths: movieList.posterPaths,
                      onTap: () => context.router.push(
                        MovieListDetailRoute(
                          listId: movieList.id,
                          listName: movieList.name,
                          posterPaths: movieList.posterPaths,
                        ),
                      ),
                    ),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  firstPageErrorIndicatorBuilder: (_) => Center(
                    child: Text(
                      AppLocalizations.of(context)?.unknownError ?? '',
                    ),
                  ),
                ),
              ),
            ),
        },
      ),
    );
  }
}
