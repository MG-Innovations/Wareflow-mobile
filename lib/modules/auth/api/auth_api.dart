import 'package:wareflow_mobile/utils/dio.dart';

class AuthAPI {
  static Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      final response = await dioClient.post('/user/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        return response.data['data']['access_token'];
      }

      return null;
    } catch (error) {
      rethrow;
    }
  }
}
