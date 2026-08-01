import 'package:profile_domain/models/user_profile.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class GetUserProfile {
  final ProfileRepository _profileRepository;

  GetUserProfile(this._profileRepository);

  Stream<UserProfile> call() => _profileRepository.watchProfile();
}
