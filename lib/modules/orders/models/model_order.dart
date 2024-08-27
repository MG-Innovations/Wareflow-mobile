import 'package:wareflow/modules/customers/model.dart';
import 'package:wareflow/utils/enums.dart';

import '../../../utils/helper_functions.dart';

class ModelOrder {
  final String id;
  final double orderValue;
  final EnumPaymentStatus status;
  final DateTime createdAt;
  double balance;
  final ModelCustomer? customer;
  final int itemCount;

  ModelOrder({
    required this.id,
    required this.orderValue,
    required this.status,
    required this.createdAt,
    required this.balance,
    required this.itemCount,
    this.customer,
  });

  factory ModelOrder.fromJson(Map<String, dynamic> json) {
    return ModelOrder(
      id: json['id'],
      orderValue: json['order_value'],
      status: HFunctions.getPaymentStatus(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      balance: json['order_value'] - json['amount_received'],
      itemCount: json['order_items_count'] ?? 0,
      customer: json['customer_details'] != null ?ModelCustomer.fromJson(json['customer_details']):null,
    );
  }
}
