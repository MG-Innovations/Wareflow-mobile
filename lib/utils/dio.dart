import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  final String baseUrl = 'http://15.207.99.128:8000/api/v1';

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('auth_token');
  }

  Future<Response> get(String path) async {
    final token = await getAuthToken();
    final url = Uri.parse('$baseUrl$path');
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    });

    return response;
  }

  Future<Response> post(String path,
      {required Map<String, dynamic> data}) async {
    final token = await getAuthToken();
    final url = Uri.parse('$baseUrl$path');
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(data));

    return response;
  }
}

final dioClient = HttpClient();
