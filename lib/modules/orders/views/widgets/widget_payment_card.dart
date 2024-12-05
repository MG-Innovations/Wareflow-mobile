import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wareflow/modules/orders/views/widgets/widget_key_value.dart';
import '../../models/model_payment.dart';

class WidgetPaymentCard extends StatelessWidget {
  final ModelPayment payment;
  const WidgetPaymentCard({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              WidgetKeyValue(
                  keyString: "Amount",
                  value: "₹" + payment.amountPaid.toString()),
              const SizedBox(height: 5),
              WidgetKeyValue(
                  keyString: "Payment Mode",
                  value: payment.paymentType.name.toUpperCase()),
              const SizedBox(height: 5),
              WidgetKeyValue(
                  keyString: "Payment Date",
                  value: DateFormat('dd/MM/yyyy')
                      .format(payment.createdAt ?? DateTime.now())),
            ],
          ),
        ));
  }
}
