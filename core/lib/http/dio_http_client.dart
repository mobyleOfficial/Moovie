import 'package:dio/dio.dart';

import 'errors/http_error.dart';
import 'http_client.dart';
import 'result/result.dart';

class DioHttpClient implements HttpClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
  }) =>
      _request(() => _dio.get(path, queryParameters: queryParams));

  @override
  Future<Result<T>> post<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Object? body,
  }) =>
      _request(() => _dio.post(path, queryParameters: queryParams, data: body));

  @override
  Future<Result<T>> put<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Object? body,
  }) =>
      _request(() => _dio.put(path, queryParameters: queryParams, data: body));

  @override
  Future<Result<T>> patch<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Object? body,
  }) =>
      _request(
        () => _dio.patch(path, queryParameters: queryParams, data: body),
      );

  Future<Result<T>> _request<T>(
    Future<Response<dynamic>> Function() call,
  ) async {
    try {
      final response = await call();
      return Success(response.data as T);
    } on DioException catch (e) {
      return Failure(_mapDioError(e));
    } catch (e) {
      return Failure(UnknownError(e.toString()));
    }
  }

  HttpError _mapDioError(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionError => const NetworkError(),
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout =>
        const TimeoutError(),
      DioExceptionType.badResponse => _mapStatusCode(e.response?.statusCode),
      _ => UnknownError(e.message ?? 'Unknown error'),
    };
  }

  HttpError _mapStatusCode(int? statusCode) => switch (statusCode) {
        401 => const UnauthorizedError(),
        404 => const NotFoundError(),
        _ when statusCode != null && statusCode >= 500 =>
          ServerError(statusCode),
        _ => const UnknownError(),
      };
}