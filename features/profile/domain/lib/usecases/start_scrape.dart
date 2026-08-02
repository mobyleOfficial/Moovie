import 'package:core/core.dart';
import 'package:profile_domain/repositories/profile_repository.dart';

class StartScrape {
  final ProfileRepository _profileRepository;

  StartScrape(this._profileRepository);

  Future<Result<void>> call({
    required String source,
    required String username,
    required String cookies,
  }) =>
      _profileRepository.startScrape(
        source: source,
        username: username,
        cookies: cookies,
      );
}
