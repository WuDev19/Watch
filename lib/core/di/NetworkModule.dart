import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:movie_app/features/movie/data/datasources/remote/interceptors/RetryInterceptor.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio provideDio() {
    final baseUrl = dotenv.get("BASE_URL");
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
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
