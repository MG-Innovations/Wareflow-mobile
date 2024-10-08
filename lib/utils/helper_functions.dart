import 'package:flutter/material.dart';
import '../utils/enums.dart';

class HFunctions {
  static String getChipText({required EnumPaymentStatus type}) {
    switch (type) {
      case EnumPaymentStatus.paymentPending:
        return "Payment Pending";
      case EnumPaymentStatus.paymentPartial:
        return "Partially Payed";
      case EnumPaymentStatus.paymentCompleted:
        return "Payment Completed";
      case EnumPaymentStatus.productOutOfStock:
        return "Out of Stock";
      case EnumPaymentStatus.productLowStock:
        return "Low Stock";
    }
  }

  static EnumPaymentStatus getPaymentStatus(String status) {
    switch (status) {
      case 'Unpaid':
        return EnumPaymentStatus.paymentPending;
      case 'Partially Paid':
        return EnumPaymentStatus.paymentPartial;
      case 'Paid':
        return EnumPaymentStatus.paymentCompleted;
      default:
        return EnumPaymentStatus.paymentPending;
    }
  }

  static EnumPaymentType getPaymentType(String paymentType) {
    switch (paymentType) {
      case 'UPI':
        return EnumPaymentType.upi;
      case 'Card':
        return EnumPaymentType.card;
      case 'Cash':
        return EnumPaymentType.cash;
      default:
        return EnumPaymentType.cash;
    }
  }

  static void showSnackbar(
      {required BuildContext context,
      required String content,
      bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: success ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
