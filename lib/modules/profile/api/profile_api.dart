import 'dart:convert';
import 'package:wareflow/utils/dio.dart';
import '../model/model_profile.dart';

class ApiProfile {
  Future<ModelProfile?> fetchUserProfile(String userId) async {
    final response = await dioClient.get('/user/$userId');

    if (response.statusCode == 200) {
      final Map<String, dynamic> profileJson = json.decode(response.body);
      return ModelProfile.fromJson(profileJson);
    } else {
      return null;
    }
  }
}
