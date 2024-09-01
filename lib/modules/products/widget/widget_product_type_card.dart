import 'package:flutter/material.dart';

import '../models/model_product.dart';

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
        child: ListTile(
          title: Text(
            productType.name ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            (productType.description != "")
                ? productType.description ?? "NA"
                : "NA",
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
        ));
  }
}
