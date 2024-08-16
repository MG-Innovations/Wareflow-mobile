// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:wareflow_mobile/modules/profile/model/model_profile.dart';

// class ApiProfile {
//   Future<Map<String, dynamic>?> fetchUserProfile(String userId) async {
//     final response = await http.get(Uri.parse(
//         'http://13.233.100.211:8000/api/v1/user/29928374-3496-4a30-a619-fc442faf7661'));

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       print('Failed to load user profile');
//       return null;
//     }
//   }
// }

// profile_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wareflow_mobile/modules/profile/model/model_profile.dart';

class ApiProfile {
  Future<ModelProfile?> fetchUserProfile(String userId) async {
    final response = await http.get(
      Uri.parse('http://13.233.100.211:8000/api/v1/user/$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> profileJson = json.decode(response.body);
      return ModelProfile.fromJson(profileJson);
    } else {
      print('Failed to load user profile');
      return null;
    }
  }
}
