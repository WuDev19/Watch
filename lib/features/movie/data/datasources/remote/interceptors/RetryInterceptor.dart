import 'dart:math';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int maxRetry = 3;
  final int _initialDelay;

  RetryInterceptor({required Dio dio, required int initialDelay})
    : _dio = dio,
      _initialDelay = initialDelay;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if(_shouldRetry(err)){
      int retry = err.requestOptions.extra["retry"] ?? 1;
      int recipeDelay = _initialDelay * pow(2, retry - 1).toInt();
      await Future.delayed(Duration(seconds: recipeDelay));
      if (retry <= maxRetry) {
        err.requestOptions.extra["retry"] = retry + 1;
        try {
          final response = await _dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;
  }
}
