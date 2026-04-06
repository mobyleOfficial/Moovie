import 'package:core/http/errors/http_error.dart';
import 'package:core/http/result/result.dart';
import 'package:core/local/local_client.dart';

class ObjectBoxClient implements LocalClient {
  @override
  Result<T> execute<T>(T Function() action) {
    try {
      return Success(action());
    } catch (_) {
      return const Failure(AppError.unknown);
    }
  }

  @override
  Stream<T> watch<T>(Stream<T> Function() action) => action();
}
