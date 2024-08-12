import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow_mobile/modules/dashboard/views/widgets/widget_analytic.dart';
import 'package:wareflow_mobile/modules/dashboard/views/widgets/widget_productitem.dart';
import 'package:wareflow_mobile/modules/orders/views/widgets/widget_order_card.dart';
import 'package:wareflow_mobile/utils/colors.dart';

class ScreenInventory extends StatelessWidget {
  const ScreenInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                // Search bar
                decoration: InputDecoration(
                  labelText: 'Search Products',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const WidgetProductItem(
                title: "Product Name", price: 20.00, quantity: 2),
            const WidgetProductItem(
                title: "Product Name",
                price: 20.00,
                quantity: 1,
                lowStock: true),
            const WidgetProductItem(
                title: "Product Name", price: 20.00, quantity: 6),
            const WidgetProductItem(
                title: "Product Name",
                price: 20.00,
                quantity: 3,
                lowStock: true),
            const WidgetProductItem(
                title: "Product Name", price: 20.00, quantity: 6),
            const WidgetProductItem(
                title: "Product Name", price: 20.00, quantity: 6),
            const WidgetProductItem(
                title: "Product Name",
                price: 20.00,
                quantity: 3,
                lowStock: true),
          ],
        ),
      ),
    );
  }
}
