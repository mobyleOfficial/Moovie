import 'package:core/core.dart';
import 'package:auth_domain/models/oauth_provider.dart';

abstract interface class AuthRepository {
  Future<Result<void>> login(OAuthProvider provider);
  Future<Result<void>> loginWithEmail(String email, String password);
  Future<Result<bool>> isUserAuthenticated();
}
