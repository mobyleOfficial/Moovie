import 'package:dio/dio.dart';
import 'package:auth/auth.dart';

class AuthInterceptor extends Interceptor {
  final SecureTokenStorage _tokenStorage;

  AuthInterceptor(this._tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenJson = await _tokenStorage.getToken();
    if (tokenJson != null) {
      final token = AuthTokenModel.fromJson(tokenJson);
      if (token.expiresAt.isAfter(DateTime.now())) {
        options.headers['Authorization'] = 'Bearer ${token.accessToken}';
      }
    }
    handler.next(options);
  }
}
