import 'package:flutter/material.dart';
import '../../../../common/widget_date.dart';
import '../../models/model_order.dart';
import 'widget_key_value.dart';
import 'widget_payment_chip.dart';

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
              Expanded(
                child: Text(
                  order.customer?.name ?? "NA",
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              WidgetDate(date: order.createdAt)
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
              getPaymentChip(order.status)
            ],
          )
        ],
      ),
    );
  }
}
