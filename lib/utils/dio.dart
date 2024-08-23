import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Dio dioClient = Dio(
  BaseOptions(
    baseUrl: 'http://15.207.99.128:8000/api/v1',
  ),
)..interceptors.add(DioInterceptors());

class DioInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final pref = await SharedPreferences.getInstance();
    options.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': "Bearer ${pref.getString('auth_token')}"
    });
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    log('RESPONSE DATA: ${response.data}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    log('ERROR: ${err.response?.data}');
    return super.onError(err, handler);
  }
}
