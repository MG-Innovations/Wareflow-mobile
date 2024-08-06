import 'package:dio/dio.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://0.0.0.0:8000/api/',
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);
