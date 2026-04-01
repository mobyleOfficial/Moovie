import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'home_bloc.dart';
import 'home_screen.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit _cubit = HomeCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(cubit: _cubit);
  }
}
