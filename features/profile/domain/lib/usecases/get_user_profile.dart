import 'package:core/core.dart';
import 'package:profile_domain/models/user_profile.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class GetUserProfile extends UseCase<void, Result<UserProfile>> {
  final ProfileRepository _profileRepository;

  GetUserProfile(this._profileRepository);

  @override
  Future<Result<UserProfile>> call([void _]) async =>
      _profileRepository.getUserProfile();
}
