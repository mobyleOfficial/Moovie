import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_profile/public_profile_info/public_profile_info_state.dart';

class PublicProfileCubit extends Cubit<PublicProfileInfoState> {
  PublicProfileCubit() : super(const PublicProfileInfoLoading()) {
    _load();
  }

  void _load() {
    // TODO: Implement actual loading logic with real data
    emit(const PublicProfileInfoLoading());
  }
}
