import 'package:core/core.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class SignUpParams {
  final String email;
  final String password;
  final String nickname;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.nickname,
  });
}

class SignUp extends UseCase<SignUpParams, Result<void>> {
  final AuthRepository _repository;

  SignUp(this._repository);

  @override
  Future<Result<void>> call([SignUpParams? params]) async =>
      _repository.signUp(params!.email, params.password, params.nickname);
}
