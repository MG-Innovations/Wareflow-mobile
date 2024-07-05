import 'package:flutter/material.dart';
import 'package:wareflow_mobile/common/widget_button.dart';
import 'package:wareflow_mobile/modules/orders/views/widgets/widget_order_card.dart';

class ScreenOrderListing extends StatelessWidget {
  const ScreenOrderListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Listing'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            WidgetOrderCard(),
            SizedBox(height: 10),
            WidgetOrderCard(),
            SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: WidgetButton(
          title: "+ Order",
          onPressed: () {
            // Add functionality here
          }),
    );
  }
}
