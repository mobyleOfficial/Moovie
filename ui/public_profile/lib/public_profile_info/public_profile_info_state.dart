import 'package:public_profile_domain/models/public_profile.dart';

sealed class PublicProfileInfoState {
  const PublicProfileInfoState();
}

class PublicProfileInfoLoading extends PublicProfileInfoState {
  const PublicProfileInfoLoading();
}

class PublicProfileInfoSuccess extends PublicProfileInfoState {
  final PublicProfile profile;

  const PublicProfileInfoSuccess(this.profile);
}

class PublicProfileInfoError extends PublicProfileInfoState {
  final String message;

  const PublicProfileInfoError(this.message);
}
