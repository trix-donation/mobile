import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

class AccessInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (TokenStorage.accessTokenKey != null) {
      options.headers['Authorization'] = 'Bearer ${TokenStorage.accessTokenKey}';
    }

    super.onRequest(options, handler);
  }
}
