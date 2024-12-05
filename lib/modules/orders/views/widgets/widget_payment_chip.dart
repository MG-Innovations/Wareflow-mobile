import 'package:flutter/material.dart';
import 'package:wareflow/common/widget_chip.dart';

import '../../../../utils/enums.dart';

Widget getPaymentChip(EnumPaymentStatus paymentStatus) {
  Color primaryColor = Colors.green;
  Color secondaryColor = Colors.green.shade100;

  switch (paymentStatus) {
    case EnumPaymentStatus.paymentPending:
      primaryColor = Colors.orange;
      secondaryColor = Colors.orange.shade100;
      break;
    case EnumPaymentStatus.paymentPartial:
      primaryColor = Colors.blue;
      secondaryColor = Colors.blue.shade100;
      break;
    case EnumPaymentStatus.paymentCompleted:
      primaryColor = Colors.green;
      secondaryColor = Colors.green.shade100;
      break;
    case EnumPaymentStatus.productOutOfStock:
      primaryColor = Colors.red;
      secondaryColor = Colors.red.shade100;
      break;
    case EnumPaymentStatus.productLowStock:
      primaryColor = Colors.yellow;
      secondaryColor = Colors.yellow.shade100;
      break;
  }

  return WidgetChip(
      primary: primaryColor,
      secondary: secondaryColor,
      chipType: paymentStatus);
}
