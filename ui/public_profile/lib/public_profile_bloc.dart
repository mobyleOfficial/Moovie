import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_profile/public_profile_info/public_profile_state.dart';

class PublicProfileCubit extends Cubit<PublicProfileState> {
  PublicProfileCubit() : super(const PublicProfileLoading()) {
    _load();
  }

  void _load() => emit(const PublicProfileSuccess());
}
