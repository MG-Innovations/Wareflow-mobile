import 'package:wareflow/utils/enums.dart';

import '../../../utils/helper_functions.dart';

class ModelPayment {
  final String id;
  final String customerName;
  final String description;
  final double amountPaid;
  final EnumPaymentType paymentType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ModelPayment({
    required this.id,
    required this.customerName,
    required this.description,
    required this.amountPaid,
    required this.paymentType,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelPayment.fromJson(Map<String, dynamic> json) {
    return ModelPayment(
      id: json['id'],
      customerName: json['customer_name'] ?? "NA",
      description: json['description'],
      amountPaid: json['amount_paid'],
      paymentType: HFunctions.getPaymentType(json['payment_type']),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['createdAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
