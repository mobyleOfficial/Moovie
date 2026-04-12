import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_profile/public_profile_info/public_profile_info_state.dart';
import 'package:public_profile_domain/usecases/get_public_profile.dart';

class PublicProfileInfoCubit extends Cubit<PublicProfileInfoState> {
  final GetPublicProfile _getPublicProfile;
  final String userId;

  PublicProfileInfoCubit({
    required GetPublicProfile getPublicProfile,
    required this.userId,
  })  : _getPublicProfile = getPublicProfile,
        super(const PublicProfileInfoLoading()) {
    _load();
  }

  Future<void> _load() async {
    final result = await _getPublicProfile(userId);

    switch (result) {
      case Success(:final data):
        emit(PublicProfileInfoSuccess(data));
      case Failure(:final error):
        emit(PublicProfileInfoError(error.message));
    }
  }

  void reload() => _load();
}
