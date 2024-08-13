import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wareflow_mobile/utils/enums.dart';

class HFunctions {
  static String getChipText({required EnumChipType type}) {
    switch (type) {
      case EnumChipType.paymentPending:
        return "Payment Pending";
      case EnumChipType.paymentPartial:
        return "Partially Payed";
      case EnumChipType.paymentCompleted:
        return "Payment Completed";
      case EnumChipType.productOutOfStock:
        return "Out of Stock";
      case EnumChipType.productLowStock:
        return "Low Stock";
    }
  }

  static void showSnackbar(
      {required BuildContext context,
      required String content,
      bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
