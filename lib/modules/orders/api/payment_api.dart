import 'dart:convert';
import 'dart:developer';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wareflow/modules/orders/models/model_payment.dart';
import 'package:wareflow/utils/dio.dart';

class PaymentAPI {
  static Future<List<ModelPayment>> getPaymentsForOrder(
      {required String orderId}) async {
    try {
      List<ModelPayment> payments = [];
      final pref = await SharedPreferences.getInstance();
      String? token = pref.getString('auth_token');
      if (token == null) {
        throw Exception('Token not found');
      }
      String tenantId = JwtDecoder.decode(token)["tenant_id"];
      final response = await dioClient
          .get('/payment/payment/order/$orderId?tenant_id=$tenantId');

      log("Response: ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        payments = data["data"]
            .map<ModelPayment>((e) => ModelPayment.fromJson(e))
            .toList();
      }
      return payments;
    } catch (error, st) {
      log("Error: $error", error: error, stackTrace: st);
      rethrow;
    }
  }

  static Future<bool> addPayment(
      {required String orderId,
      required String amount,
      required String paymentType,
      required String description}) async {
    try {
      final response = await dioClient.post('/payment/payment', data: {
        "order_id": orderId,
        "amount_paid": amount,
        "payment_type": paymentType,
        "description": description
      });

      log("Response: ${response.body}");
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (error) {
      rethrow;
    }
  }
}
