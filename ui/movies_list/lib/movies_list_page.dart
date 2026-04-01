import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';

import 'movies_list_bloc.dart';
import 'movies_list_screen.dart';

@RoutePage()
class MoviesListPage extends StatefulWidget {
  final GetTrendingMovies getTrendingMovies;

  const MoviesListPage({super.key, required this.getTrendingMovies});

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  late final MoviesListCubit _cubit = MoviesListCubit(widget.getTrendingMovies);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MoviesListScreen(cubit: _cubit);
  }
}
