import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile/profile.dart';
import 'package:profile_ui/edit_profile/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UpdateUserProfile _updateUserProfile;

  String _photoUrl;
  String _username;
  String _bio;

  bool _hasChanges = false;

  EditProfileCubit({
    required UpdateUserProfile updateUserProfile,
    required String initialPhotoUrl,
    required String initialUsername,
    required String initialBio,
  })  : _updateUserProfile = updateUserProfile,
        _photoUrl = initialPhotoUrl,
        _username = initialUsername,
        _bio = initialBio,
        super(EditProfileReady(
          photoUrl: initialPhotoUrl,
          username: initialUsername,
          bio: initialBio,
        ));

  void onPhotoUrlChanged(String photoUrl) {
    _photoUrl = photoUrl;
    _hasChanges = true;
    emit(EditProfileReady(
      photoUrl: _photoUrl,
      username: _username,
      bio: _bio,
    ));
  }

  void onUsernameChanged(String username) {
    _username = username;
    _hasChanges = true;
  }

  void onBioChanged(String bio) {
    _bio = bio;
    _hasChanges = true;
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
}
