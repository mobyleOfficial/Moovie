import 'package:profile_domain/repositories/profile_repository.dart';

class FetchUserProfile {
  final ProfileRepository _profileRepository;

  FetchUserProfile(this._profileRepository);

  Future<void> call() => _profileRepository.fetchProfile();
}
