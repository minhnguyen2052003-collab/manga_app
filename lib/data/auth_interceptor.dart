import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  String? accessToken;

  void upDateToken(String token){
    accessToken = token;
  }

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }
}
