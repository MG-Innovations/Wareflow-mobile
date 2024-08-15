import 'dart:developer';

import 'package:wareflow_mobile/modules/orders/models/model_order.dart';
import 'package:wareflow_mobile/modules/orders/views/screen_create_order.dart';

import '../../../utils/dio.dart';

class OrderAPI {
  static Future<bool> createOrder({
    required String customerId,
    required List<ModelProductTableItem> products,
    required String totalPrice,
  }) async {
    try {
      Map<String, dynamic> payload = {};
      List<Map<String, dynamic>> productsPayload = [];

      for (var product in products) {
        Map<String, dynamic> productPayload = {};
        productPayload['product_id'] = product.product.id;
        productPayload['quantity'] = product.quantity;
        productPayload['price'] = product.cost;
        productsPayload.add(productPayload);
      }
      payload['customer_id'] = customerId;

      payload['order_items'] = productsPayload;
      payload['order_value'] = totalPrice;

      log("Payload: $payload");
      final response = await dioClient.post('/order/', data: payload);
      log("Response: ${response.data}");
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<ModelOrder>> getAllOrders() async {
    List<ModelOrder> orders = [];
    try {
      final response = await dioClient.get('/order/?limit=10&offset=0');
      if (response.statusCode == 200) {
        for (var item in response.data["data"]["orders"]) {
          orders.add(ModelOrder.fromJson(item));
        }
      }
      return orders;
    } catch (error, st) {
      log("Error: $error Stacktrace: ${st}");
      rethrow;
    }
  }
}
