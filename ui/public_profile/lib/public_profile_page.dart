import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart';
import 'package:movies_ui/tabs/lists/movies_lists_bloc.dart';
import 'package:profile/profile.dart';
import 'package:public_profile/public_profile_info/public_profile_info_bloc.dart';
import 'package:public_profile/public_profile_screen.dart';
import 'package:public_profile_domain/usecases/get_public_profile.dart';

@RoutePage()
class PublicProfilePage extends StatefulWidget {
  final String userId;

  const PublicProfilePage({super.key, required this.userId});

  @override
  State<PublicProfilePage> createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  late final PublicProfileInfoCubit _cubit = PublicProfileInfoCubit(
    getPublicProfile: GetIt.I<GetPublicProfile>(),
    userId: widget.userId,
  );
  late final GetUserReviews _getUserReviews = GetIt.I<GetUserReviews>();
  late final MoviesListsCubit _listsCubit =
      MoviesListsCubit(GetIt.I<GetMovieLists>(), userId: widget.userId);

  @override
  void dispose() {
    _cubit.close();
    _listsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PublicProfileScreen(
        cubit: _cubit,
        userId: widget.userId,
        getUserReviews: _getUserReviews,
        listsCubit: _listsCubit,
      );
}
