import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/tabs/lists/movies_lists_bloc.dart';
import 'package:movies_ui/tabs/lists/movies_lists_screen.dart';

class PublicProfileListsTab extends StatefulWidget {
  final String userId;

  const PublicProfileListsTab({
    super.key,
    required this.userId,
  });

  @override
  State<PublicProfileListsTab> createState() => _PublicProfileListsTabState();
}

class _PublicProfileListsTabState extends State<PublicProfileListsTab> {
  late final MoviesListsCubit _cubit =
      MoviesListsCubit(GetIt.I<GetMovieLists>(), userId: widget.userId);

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MoviesListsScreen(
        cubit: _cubit,
        showPopularHeader: false,
      );
}
