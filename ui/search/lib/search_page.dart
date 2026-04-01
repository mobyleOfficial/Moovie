import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'search_bloc.dart';
import 'search_screen.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchCubit _cubit = SearchCubit();

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchScreen(cubit: _cubit);
  }
}
