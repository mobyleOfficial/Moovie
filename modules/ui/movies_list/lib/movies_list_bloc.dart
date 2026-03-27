import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_list_state.dart';

abstract class MoviesListEvent {
  const MoviesListEvent();
}

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  MoviesListBloc() : super(const MoviesListInitial());
}