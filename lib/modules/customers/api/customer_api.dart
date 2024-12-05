import 'dart:convert';
import 'dart:developer';

import '../../../utils/dio.dart';
import '../../../widgets/common_textfield.dart';
import '../models/model_customer.dart';

class CustomerApi {
  static Future<List<ModelCustomer>> getAllCustomers(
      {required String query}) async {
    try {
      final response = await dioClient.get('/customer');
      List<ModelCustomer> customers = [];
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var item in data["data"]) {
          customers.add(ModelCustomer.fromJson(item));
        }
      }

      return customers;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ModelDropdown>> getAllCustomersDropdown(
      {required String query}) async {
    try {
      final response = await dioClient.get('/customer');
      List<ModelDropdown> customers = [];
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var item in data["data"]) {
          customers.add(ModelDropdown(id: item['id'], name: item['name']));
        }
      }

      return customers;
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

      final response = await dioClient.post('/customer/', data: customerData);

      if (response.statusCode == 201) {
        log('Customer added successfully: ${response.body}');
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
