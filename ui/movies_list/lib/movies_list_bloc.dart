import 'package:flutter_bloc/flutter_bloc.dart';

import 'movies_list_state.dart';

class MoviesListCubit extends Cubit<MoviesListState> {
  MoviesListCubit() : super(const MoviesListLoading());
}