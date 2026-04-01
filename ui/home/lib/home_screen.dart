import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_list/movies_list_router.dart';
import 'package:reviews/reviews_router.dart';

import 'home_bloc.dart';

class HomeScreen extends StatelessWidget {
  final HomeCubit cubit;

  const HomeScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: AutoTabsRouter.tabBar(
        routes: const [
          MoviesListRoute(),
          ReviewsRoute(),
        ],
        builder: (context, child, tabController) {
          return Column(
            children: [
              TabBar(
                controller: tabController,
                tabs: const [
                  Tab(text: 'Movies'),
                  Tab(text: 'Reviews'),
                ],
              ),
              Expanded(child: child),
            ],
          );
        },
      ),
    );
  }
}
