import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/core/config/data/auth_interceptor.dart';
import 'package:mobile_test/src/core/config/data/curl_logger_interceptor.dart';

@module
abstract class DataModule {
  @Named("BaseUrl")
  String get baseUrl => 'https://mobile-test.free.mockoapp.net/';

  @singleton
  Dio dio(
    @Named('BaseUrl') String url,
    AuthInterceptor authInterceptor,
  ) {
    var dio = Dio(
      BaseOptions(
        baseUrl: url,
        connectTimeout: const Duration(minutes: 10),
        receiveTimeout: const Duration(minutes: 10),
      ),
    );

    dio.interceptors.add(authInterceptor);

    dio.interceptors.add(CurlLoggerInterceptor());

    return dio;
  }
}
