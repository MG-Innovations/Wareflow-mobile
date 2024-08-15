import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';

class WidgetProductCard extends StatelessWidget {
  final ModelProduct product;
  final bool selected;
  const WidgetProductCard({
    super.key,
    required this.product,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.grey[200] : Colors.white,
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
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
