import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:profile_ui/profile_screen.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => const ProfileScreen();
}
