import 'dart:convert';
import 'dart:developer';

import 'package:wareflow/modules/dashboard/models/model_dashboard.dart';
import 'package:wareflow/utils/dio.dart';

class DashboardApi {
  static Future<ModelDashboard?> getAnanlyticsData() async {
    try {
      final response = await dioClient.get('/analytics/dashboard');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ModelDashboard.fromJSON(json: data["data"]);
      }
      return null;
    } catch (error, st) {
      log("Error: $error , Stack trace: $st");
      rethrow;
    }
  }
}
