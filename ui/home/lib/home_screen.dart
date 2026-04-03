import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  final HomeCubit cubit;

  const HomeScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: cubit,
    child: const AutoRouter(),
  );
}
