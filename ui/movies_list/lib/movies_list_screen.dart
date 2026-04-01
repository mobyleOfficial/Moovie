import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movies/movies.dart';
import 'package:movies_list/movies_list_bloc.dart';
import 'package:movies_list/movies_list_state.dart';

class MoviesListScreen extends StatelessWidget {
  final MoviesListCubit cubit;
  final void Function(int movieId) onMovieTap;

  const MoviesListScreen({
    super.key,
    required this.cubit,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<MoviesListCubit, MoviesListState>(
        listener: (context, state) {},
        child: PagingListener(
          controller: cubit.pagingController,
          builder: (context, pagingState, fetchNextPage) =>
              PagedListView<int, Movie>(
                state: pagingState,
                fetchNextPage: fetchNextPage,
                builderDelegate: PagedChildBuilderDelegate<Movie>(
                  itemBuilder: (context, movie, index) => ListTile(
                    title: Text(movie.title),
                    subtitle: Text(movie.releaseDate),
                    onTap: () => onMovieTap(movie.id),
                  ),
                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  firstPageErrorIndicatorBuilder: (_) =>
                      BlocBuilder<MoviesListCubit, MoviesListState>(
                        builder: (context, state) => Center(
                          child: Text(
                            state is MoviesListError
                                ? state.message
                                : AppLocalizations.of(context)!.unknownError,
                          ),
                        ),
                      ),
                ),
              ),
        ),
      ),
    );
  }
}
