import 'package:social/social_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(const SocialLoading()) {
    _load();
  }

  void _load() => emit(const SocialSuccess());
}
