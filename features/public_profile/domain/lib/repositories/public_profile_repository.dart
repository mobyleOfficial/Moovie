import 'package:core/core.dart';
import 'package:public_profile_domain/models/public_profile.dart';

abstract interface class PublicProfileRepository {
  Future<Result<PublicProfile>> getPublicProfile({required String userId});
}
