import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';

class WidgetProductTypeCard extends StatelessWidget {
  final ProductType productType;
  const WidgetProductTypeCard({super.key, required this.productType});

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
            Text(productType.name ?? ''),
            const SizedBox(height: 8),
            Text(productType.description ?? '')
          ],
        ),
      ),
    );
    ;
  }
}
