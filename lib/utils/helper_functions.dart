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
}
