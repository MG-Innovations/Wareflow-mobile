import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/model.dart';

class WidgetProductCard extends StatelessWidget {
  final ModelProduct product;
  const WidgetProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name ?? "NA",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text("Price: ₹ ${product.sellingPrice}"),
                const SizedBox(width: 16),
                Text("Stock: ${product.stock}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
