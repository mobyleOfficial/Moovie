import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/tabs/lists/user_movie_lists_bloc.dart';
import 'package:profile_ui/tabs/lists/user_movie_lists_screen.dart';

class UserMovieListsPage extends StatefulWidget {
  const UserMovieListsPage({super.key});

  @override
  State<UserMovieListsPage> createState() => _UserMovieListsPageState();
}

class _UserMovieListsPageState extends State<UserMovieListsPage> {
  late final UserMovieListsCubit _cubit = UserMovieListsCubit(
    getMovieLists: GetIt.I<GetMovieLists>(),
    getUserProfile: GetIt.I<ObserveUserProfile>(),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => UserMovieListsScreen(cubit: _cubit);
}
