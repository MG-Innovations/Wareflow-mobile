import 'package:dio/dio.dart';
import 'package:wareflow_mobile/main.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: 'http://15.207.99.128:8000/api/v1',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${pref!.getString('auth_token')}"
    },
  ),
);
