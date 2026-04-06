import 'package:core/http/result/result.dart';

abstract interface class LocalClient {
  Result<T> execute<T>(T Function() action);
  Stream<T> watch<T>(Stream<T> Function() action);
}
