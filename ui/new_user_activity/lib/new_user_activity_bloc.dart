import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_user_activity/new_user_activity_state.dart';

class NewUserActivityCubit extends Cubit<NewUserActivityState> {
  NewUserActivityCubit() : super(const NewUserActivityLoading());
}
