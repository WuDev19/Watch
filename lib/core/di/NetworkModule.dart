import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/remote/interceptors/RetryInterceptor.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://ophim1.com",
        connectTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {"Content-Type": "application/json"},
      ),
    );
    dio.interceptors.add(RetryInterceptor(dio: dio, initialDelay: 1));
    return dio;
  }
  
}
