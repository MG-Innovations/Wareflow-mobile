import 'package:flutter/material.dart';

class WidgetProductItem extends StatelessWidget {
  final String title;
  final double price;
  final int quantity;
  final bool lowStock;

  const WidgetProductItem({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
    this.lowStock = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price: \$${price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14.0),
              ),
              Text(
                'Qty: $quantity',
                style: const TextStyle(fontSize: 14.0),
              ),
              if (lowStock) // Only show if lowStock is true
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Low Stock',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
