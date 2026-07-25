import 'package:core/core.dart';
import 'package:auth_domain/repositories/auth_repository.dart';

class CheckNicknameAvailability extends UseCase<String, Result<bool>> {
  final AuthRepository _repository;

  CheckNicknameAvailability(this._repository);

  @override
  Future<Result<bool>> call([String? params]) async =>
      _repository.checkNicknameAvailability(params!);
}
