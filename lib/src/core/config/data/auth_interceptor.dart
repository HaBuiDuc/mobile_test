import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_test/src/features/auth/data/datasources/local/auth_local.dart';


@LazySingleton()
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource authLocalDataSource;

  AuthInterceptor(this.authLocalDataSource);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await authLocalDataSource.getAccessToken();

    if (accessToken != null && 
        !options.path.contains('/auth/login') && 
        !options.path.contains('/auth/refresh')) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final originalRequest = err.requestOptions;

      if (originalRequest.path.contains('/auth/refresh')) {
        await authLocalDataSource.clearTokens();
        return handler.reject(err);
      }
      
      try {
        final refreshToken = await authLocalDataSource.getRefreshToken();
        
        if (refreshToken != null) {

          final refreshDio = Dio(
            BaseOptions(baseUrl: originalRequest.baseUrl),
          );
          
          final response = await refreshDio.post('/auth/refresh', data: {
            'refreshToken': refreshToken,
          });
          
          if (response.statusCode == 200) {
            final newAccess = response.data['access_token'] as String;
            final newRefresh = response.data['refresh_token'] as String;
            
            await authLocalDataSource.saveTokens(newAccess, newRefresh);
            
            originalRequest.headers['Authorization'] = 'Bearer $newAccess';
            

            final retryResponse = await refreshDio.fetch(originalRequest);
            
            return handler.resolve(retryResponse);
          }
        }
      } catch (e) {
        await authLocalDataSource.clearTokens();
      }
    }
    
    return handler.next(err);
  }
}