import 'package:wareflow_mobile/modules/customers/models/model_customer.dart';
import 'package:wareflow_mobile/utils/dio.dart';

class CustomerApi {
  static Future<List<ModelCustomer>> getAllCustomers(
      {required String query}) async {
    String query;
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
}
