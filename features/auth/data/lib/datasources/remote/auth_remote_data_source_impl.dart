import 'package:core/core.dart';
import 'package:auth_data/datasources/remote/auth_remote_data_source.dart';
import 'package:auth_data/models/auth_token_model.dart';
import 'package:auth_data/models/login_response_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient _httpClient;

  AuthRemoteDataSourceImpl(this._httpClient);

  @override
  Future<Result<AuthTokenModel>> login(
    String email,
    String password,
  ) async {
    final result = await _httpClient.post<Map<String, dynamic>>(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    return switch (result) {
      Success<Map<String, dynamic>>(:final data) =>
        Success(LoginResponseModel.fromJson(data).toAuthTokenModel()),
      Failure<Map<String, dynamic>>(:final error) => Failure(error),
    };
  }
}
