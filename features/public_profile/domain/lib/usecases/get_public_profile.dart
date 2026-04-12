import 'package:core/core.dart';
import 'package:public_profile_domain/models/public_profile.dart';
import 'package:public_profile_domain/repositories/public_profile_repository.dart';

class GetPublicProfile extends UseCase<String, Result<PublicProfile>> {
  final PublicProfileRepository _publicProfileRepository;

  GetPublicProfile(this._publicProfileRepository);

  @override
  Future<Result<PublicProfile>> call([String? params]) async =>
      _publicProfileRepository.getPublicProfile(userId: params ?? '');
}
