import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

import 'movies_list_bloc.dart';
import 'movies_list_state.dart';

class MoviesListScreen extends StatelessWidget {
  final MoviesListCubit cubit;

  const MoviesListScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<MoviesListCubit, MoviesListState>(
        builder: (context, state) {
          return switch (state) {
            MoviesListLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            MoviesListSuccess(:final movies) => ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text(movie.releaseDate),
                  );
                },
              ),
            MoviesListError(:final message) => Center(
                child: Text(message),
              ),
          };
        },
      ),
    );
  }
}
