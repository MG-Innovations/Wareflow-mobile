// import 'dart:math';
// import 'package:wareflow_mobile/modules/customers/model.dart';
// import 'package:wareflow_mobile/utils/dio.dart';

// class CustomerAPI {
//   static Future<List<ModelCustomer>> getCustomers() async {
//     List<ModelCustomer> customers = [];
//     try {
//       final response = await dioClient.get('/customer/');
//       if (response.statusCode == 200) {
//         for (var item in response.data["data"]) {
//           customers.add(ModelCustomer.fromJson(item));
//         }
//         return customers;
//       } else {
//         return [];
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }

//   // static Future<void> postData({
//   //   required String customerName,
//   //   required String customerEmail,
//   //  }) async {
//   //   try {
//   //     final customerData = {
//   //       "name": customerName,
//   //       "email": customerEmail,
//   //     };

//   //     log(customerData.toString());
//   //     final response = await dioClient.post('/customer/', data: customerData);

//   //     log(response.toString());

//   //     if (response.statusCode == 200) {
//   //       return true;
//   //     }
//   //     return false;
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
// }

import 'package:wareflow_mobile/modules/customers/model.dart';
import 'package:wareflow_mobile/utils/dio.dart';

class CustomerAPI {
  static Future<List<ModelCustomer>> getCustomers() async {
    List<ModelCustomer> customers = [];
    try {
      final response = await dioClient.get('/customer/');
      if (response.statusCode == 200) {
        for (var item in response.data["data"]) {
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
