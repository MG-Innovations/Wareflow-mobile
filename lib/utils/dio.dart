import 'package:dio/dio.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: 'http://13.233.100.211:8000/api/v1',
    connectTimeout: const Duration(milliseconds: 1000),
    receiveTimeout: const Duration(milliseconds: 1000),
    headers: {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MjQwMTAwMTQsInVzZXJfaWQiOiIyOTkyODM3NC0zNDk2LTRhMzAtYTYxOS1mYzQ0MmZhZjc2NjEiLCJ0ZW5hbnRfaWQiOiI1MGI2Yjc1YS02ZTVlLTQ1ODYtOTBmMi0zYzNlMTc2ZWNmMWIifQ.HKC4AMIkp7WNpHgvqrK9IWmPHFDtzjvUjOOhY7jgVBI"
    },
  ),
);
