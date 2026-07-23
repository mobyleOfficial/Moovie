import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:auth_domain/models/oauth_provider.dart';
import 'package:auth_domain/repositories/auth_repository.dart';
import 'package:auth_data/datasources/oauth_remote_data_source.dart';
import 'package:auth_data/datasources/remote/auth_remote_data_source.dart';
import 'package:auth_data/datasources/auth_local_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final OAuthRemoteDataSource _oauthRemoteDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(
    this._oauthRemoteDataSource,
    this._authRemoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<void>> login(OAuthProvider provider) async {
    final providerString =
        provider == OAuthProvider.google ? 'google' : 'facebook';

    final oauthResult =
        await _oauthRemoteDataSource.initiateOAuth(providerString);

    switch (oauthResult) {
      case Success(:final data):
        final tokenResult =
            await _oauthRemoteDataSource.completeOAuth(data);

        switch (tokenResult) {
          case Success(:final data):
            return _localDataSource.saveToken(data);
          case Failure(:final error):
            return Failure(error);
        }
      case Failure(:final error):
        return Failure(error);
    }
  }

  @override
  Future<Result<void>> loginWithEmail(String email, String password) async {
    final result = await _authRemoteDataSource.login(email, password);

    switch (result) {
      case Success(:final data):
        return _localDataSource.saveToken(data);
      case Failure(:final error):
        return Failure(error);
    }
  }

  @override
  Future<Result<bool>> isUserAuthenticated() async {
    final result = await _localDataSource.getToken();

    return switch (result) {
      Success(:final data) => Success(
          data != null && data.expiresAt.isAfter(DateTime.now()),
        ),
      Failure(:final error) => Failure(error),
    };
  }
}
