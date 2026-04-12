import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:public_profile/public_profile_screen.dart';

@RoutePage()
class PublicProfilePage extends StatelessWidget {
  final String userId;

  const PublicProfilePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) => PublicProfileScreen(userId: userId);
}
