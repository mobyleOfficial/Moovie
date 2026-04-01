import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_bloc.dart';
import 'search_state.dart';

@RoutePage()
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return switch (state) {
            SearchLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            SearchSuccess() => const Center(
                child: Text('Search'),
              ),
            SearchError() => Center(
                child: Text(state.message),
              ),
          };
        },
      ),
    );
  }
}