import 'package:core/core.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class LoginWithEmailParams {
  final String email;
  final String password;

  const LoginWithEmailParams({required this.email, required this.password});
}

class LoginWithEmail extends UseCase<LoginWithEmailParams, Result<void>> {
  final AuthRepository _repository;

  LoginWithEmail(this._repository);

  @override
  Future<Result<void>> call([LoginWithEmailParams? params]) async =>
      _repository.loginWithEmail(params!.email, params.password);
}
