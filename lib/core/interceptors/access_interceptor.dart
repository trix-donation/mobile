import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

class AccessInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = TokenStorage.accessTokenKey;

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    super.onRequest(options, handler);
  }
}
