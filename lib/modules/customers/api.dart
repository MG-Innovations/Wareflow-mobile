import 'dart:convert';
import '../../utils/dio.dart';
import 'model.dart';

class CustomerAPI {
  static Future<List<ModelCustomer>> getCustomers() async {
    List<ModelCustomer> customers = [];
    try {
      final response = await dioClient.get('/customer/');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var item in data["data"]) {
          customers.add(ModelCustomer.fromJson(item));
        }
        return customers;
      } else {
        return [];
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> submitCustomer({
    required String customerName,
    required String customerNumber,
  }) async {
    try {
      final customerData = {
        "name": customerName,
        "phone_number": customerNumber,
      };

      final response = await dioClient.post('/customer', data: customerData);

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
