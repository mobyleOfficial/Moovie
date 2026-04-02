import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_info_state.dart';

class ProfileCubit extends Cubit<ProfileInfoState> {
  ProfileCubit() : super(const ProfileInfoLoading()) {
    _load();
  }

  void _load() => emit(const ProfileInfoSuccess());
}