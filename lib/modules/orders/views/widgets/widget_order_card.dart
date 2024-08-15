import 'package:flutter/material.dart';
import 'package:wareflow_mobile/common/widget_chip.dart';
import 'package:wareflow_mobile/common/widget_date.dart';
import 'package:wareflow_mobile/modules/orders/models/model_order.dart';
import 'package:wareflow_mobile/modules/orders/views/widgets/widget_key_value.dart';
import 'package:wareflow_mobile/utils/enums.dart';

class WidgetOrderCard extends StatelessWidget {
  final ModelOrder order;
  const WidgetOrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                order.customerName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              WidgetDate(date: DateTime.now())
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetKeyValue(
                  keyString: "Order Value", value: order.orderValue.toString()),
              WidgetKeyValue(
                  keyString: "Balance", value: order.balance.toString()),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetKeyValue(
                  keyString: "Items", value: order.itemCount.toString()),
              WidgetChip(
                  primary: Colors.red,
                  secondary: Colors.red.shade100,
                  chipType: EnumChipType.paymentPending)
            ],
          )
        ],
      ),
    );
  }
}
