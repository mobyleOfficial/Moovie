import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:moovie/config/app_config.dart';

@module
abstract class HttpDiModule {
  @singleton
  @Named('tmdb')
  Dio get tmdbDio => Dio(
        BaseOptions(
          baseUrl: 'https://api.themoviedb.org/3/',
          headers: {
            'Authorization':
                'Bearer ${const String.fromEnvironment('TMDB_API_KEY')}',
            'accept': 'application/json',
          },
        ),
      );

  @singleton
  @Named('backend')
  Dio get backendDio => Dio(
        BaseOptions(
          baseUrl: AppConfig.instance.backendUrl,
          headers: {
            'accept': 'application/json',
          },
        ),
      );

  @singleton
  @Named('tmdb')
  HttpClient tmdbClient(@Named('tmdb') Dio dio) => DioHttpClient(dio);

  @singleton
  @Named('backend')
  HttpClient backendClient(@Named('backend') Dio dio) => DioHttpClient(dio);

  @singleton
  LocalClient get localClient => ObjectBoxClient();
}
