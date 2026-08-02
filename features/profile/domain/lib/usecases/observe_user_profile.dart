import 'package:profile_domain/models/user_profile.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class ObserveUserProfile {
  final ProfileRepository _profileRepository;

  ObserveUserProfile(this._profileRepository);

  Stream<UserProfile> call() => _profileRepository.watchProfile();
}
