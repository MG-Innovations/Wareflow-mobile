import 'dart:convert';
import 'package:wareflow/utils/dio.dart';
import '../model/model_profile.dart';

class ApiProfile {
  Future<ModelProfile?> fetchUserProfile(String userId) async {
    final response = await dioClient.get('/user/');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return ModelProfile.fromJson(data["data"]);
    } else {
      return null;
    }
  }
}
