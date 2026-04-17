import 'package:core/core.dart';
import 'package:profile_domain/models/user_profile.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class UpdateUserProfile extends UseCase<UserProfile, Result<void>> {
  final ProfileRepository _profileRepository;

  UpdateUserProfile(this._profileRepository);

  @override
  Future<Result<void>> call([UserProfile? params]) async =>
      _profileRepository.updateUserProfile(profile: params!);
}
