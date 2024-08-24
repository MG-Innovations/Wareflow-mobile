import 'package:flutter/material.dart';
import 'package:wareflow/modules/orders/models/model_order.dart';
import 'package:wareflow/modules/orders/views/widgets/widget_key_value.dart';
import 'package:wareflow/modules/orders/views/widgets/widget_payment_chip.dart';

class ScreenOrderDetails extends StatefulWidget {
  final ModelOrder order;
  const ScreenOrderDetails({super.key, required this.order});

  @override
  State<ScreenOrderDetails> createState() => _ScreenOrderDetailsState();
}

class _ScreenOrderDetailsState extends State<ScreenOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Screen Order Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    WidgetKeyValue(
                        keyString: "Customer Name",
                        value: widget.order.customer.name),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Customer Contact Info",
                        value: widget.order.customer.phoneNumber),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Total order value",
                        value: widget.order.orderValue.toString()),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Balance",
                        value: widget.order.balance.toString()),
                    const SizedBox(height: 5),
                    WidgetKeyValue(
                        keyString: "Total Products",
                        value: widget.order.itemCount.toString()),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text(
                          "Payment Status: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        getPaymentChip(widget.order.status)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text("Payments ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          ],
        ),
      ),
    );
  }
}
