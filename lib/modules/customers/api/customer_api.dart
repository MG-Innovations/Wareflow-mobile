import 'package:wareflow_mobile/modules/customers/models/model_customer.dart';
import 'package:wareflow_mobile/utils/dio.dart';
import 'package:wareflow_mobile/widgets/common_textfield.dart';

class CustomerApi {
  static Future<List<ModelCustomer>> getAllCustomers(
      {required String query}) async {
    try {
      final response = await dioClient.get('/customer');
      List<ModelCustomer> customers = [];
      if (response.statusCode == 200) {
        for (var item in response.data["data"]) {
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
        for (var item in response.data["data"]) {
          customers.add(ModelDropdown(id: item['id'], name: item['name']));
        }
      }

      return customers;
    } catch (error) {
      rethrow;
    }
  }
}
