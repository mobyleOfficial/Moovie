import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';
import 'package:profile_ui/edit_profile/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateUserProfile _updateUserProfile;
  final StartScrape _startScrape;
  final GetUserProfile _getUserProfile;

  StreamSubscription<UserProfile>? _profileSubscription;

  String _photoUrl;
  String _username;
  String _bio;
  bool _isScraping;

  bool _hasChanges = false;

  EditProfileCubit({
    required UpdateUserProfile updateUserProfile,
    required StartScrape startScrape,
    required GetUserProfile getUserProfile,
    required String initialPhotoUrl,
    required String initialUsername,
    required String initialBio,
    required bool initialIsScraping,
  })  : _updateUserProfile = updateUserProfile,
        _startScrape = startScrape,
        _getUserProfile = getUserProfile,
        _photoUrl = initialPhotoUrl,
        _username = initialUsername,
        _bio = initialBio,
        _isScraping = initialIsScraping,
        super(EditProfileReady(
          photoUrl: initialPhotoUrl,
          username: initialUsername,
          bio: initialBio,
          isScraping: initialIsScraping,
        )) {
    _profileSubscription = _getUserProfile().listen((profile) {
      _isScraping = profile.isScraping;
      _emitReady();
    });
  }

  void onPhotoUrlChanged(String photoUrl) {
    _photoUrl = photoUrl;
    _hasChanges = true;
    _emitReady();
  }

  void onUsernameChanged(String username) {
    _username = username;
    _hasChanges = true;
  }

  void onBioChanged(String bio) {
    _bio = bio;
    _hasChanges = true;
  }

  Future<void> importFromSource({
    required String source,
    required String username,
    required String cookies,
  }) async {
    if (_isScraping) return;

    _isScraping = true;
    _emitReady();

    final result = await _startScrape(
      source: source,
      username: username,
      cookies: cookies,
    );
    if (result is Failure) {
      _isScraping = false;
      _emitReady();
    }
  }

  Future<UserProfile?> saveIfChanged() async {
    if (!_hasChanges) return null;

    final profile = UserProfile(
      photoUrl: _photoUrl,
      username: _username,
      bio: _bio,
    );
    await _updateUserProfile(profile);
    return profile;
  }

  void _emitReady() {
    emit(EditProfileReady(
      photoUrl: _photoUrl,
      username: _username,
      bio: _bio,
      isScraping: _isScraping,
    ));
  }

  @override
  Future<void> close() {
    _profileSubscription?.cancel();
    return super.close();
  }
}
