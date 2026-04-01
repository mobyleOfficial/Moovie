import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_bloc.dart';
import 'search_state.dart';

class SearchScreen extends StatelessWidget {
  final SearchCubit cubit;

  const SearchScreen({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
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
