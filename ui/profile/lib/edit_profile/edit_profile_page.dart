import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:profile/profile.dart';
import 'package:profile_ui/edit_profile/edit_profile_bloc.dart';
import 'package:profile_ui/edit_profile/edit_profile_screen.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  final String initialPhotoUrl;
  final String initialUsername;
  final String initialBio;

  const EditProfilePage({
    super.key,
    required this.initialPhotoUrl,
    required this.initialUsername,
    required this.initialBio,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final EditProfileCubit _cubit = EditProfileCubit(
    updateUserProfile: GetIt.I<UpdateUserProfile>(),
    initialPhotoUrl: widget.initialPhotoUrl,
    initialUsername: widget.initialUsername,
    initialBio: widget.initialBio,
  );

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => EditProfileScreen(cubit: _cubit);
}
