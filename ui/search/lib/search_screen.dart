import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search_bloc.dart';
import 'package:search/search_state.dart';

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
            SearchSuccess() => Center(
                child: Text(AppLocalizations.of(context)!.search),
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
