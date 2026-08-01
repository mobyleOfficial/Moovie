import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:profile/profile.dart';

import 'package:profile_ui/tabs/watchlist/watchlist_bloc.dart';
import 'package:profile_ui/tabs/watchlist/watchlist_screen.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  late final WatchlistCubit _cubit = WatchlistCubit(
    getUserWatchList: GetIt.I<GetUserWatchList>(),
    getUserProfile: GetIt.I<GetUserProfile>(),
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WatchlistScreen(cubit: _cubit);
}
