import 'package:dio/dio.dart';
import 'package:wareflow_mobile/main.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: 'http://13.233.100.211:8000/api/v1',
    connectTimeout: const Duration(milliseconds: 1000),
    receiveTimeout: const Duration(milliseconds: 1000),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${pref!.getString('auth_token')}"
    },
  ),
);
