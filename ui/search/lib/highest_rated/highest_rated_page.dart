import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/movie_detail/movie_detail_router.dart';

import 'package:search/highest_rated/highest_rated_bloc.dart';
import 'package:search/highest_rated/highest_rated_screen.dart';

@RoutePage()
class HighestRatedPage extends StatefulWidget {
  const HighestRatedPage({super.key});

  @override
  State<HighestRatedPage> createState() => _HighestRatedPageState();
}

class _HighestRatedPageState extends State<HighestRatedPage> {
  late final HighestRatedCubit _cubit = HighestRatedCubit(
    GetIt.I<DiscoverMovies>(),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => HighestRatedScreen(
        cubit: _cubit,
        onMovieTap: (movieId, movieTitle) => context.router.push(
          MovieDetailRoute(movieId: movieId, movieTitle: movieTitle),
        ),
      );
}
