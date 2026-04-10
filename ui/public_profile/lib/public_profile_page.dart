import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profile/profile.dart';
import 'package:public_profile/public_profile_bloc.dart';
import 'package:public_profile/public_profile_screen.dart';

@RoutePage()
class PublicProfilePage extends StatefulWidget {
  final String userId;

  const PublicProfilePage({super.key, required this.userId});

  @override
  State<PublicProfilePage> createState() => _PublicProfilePageState();
}

class _PublicProfilePageState extends State<PublicProfilePage> {
  late final PublicProfileCubit _cubit = PublicProfileCubit();
  late final GetUserReviews _getUserReviews = GetIt.I<GetUserReviews>();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PublicProfileScreen(
        cubit: _cubit,
        userId: widget.userId,
        getUserReviews: _getUserReviews,
      );
}
