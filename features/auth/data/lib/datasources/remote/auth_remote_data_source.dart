import 'package:core/core.dart';
import 'package:auth_data/models/auth_token_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<Result<AuthTokenModel>> login(String email, String password);
}
