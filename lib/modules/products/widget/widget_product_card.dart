// import 'package:flutter/material.dart';
// import 'package:wareflow_mobile/modules/products/models/model_product.dart';

// class WidgetProductCard extends StatelessWidget {
//   final ModelProduct product;
//   const WidgetProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.black),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               product.name ?? "NA",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 Text("Price: ₹ ${product.sellingPrice}"),
//                 const SizedBox(width: 16),
//                 Text("Stock: ${product.stock}"),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';

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
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? "NA",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
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
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(product.name ?? 'Product Info'),
                      content: Text(
                          'Price: ₹${product.sellingPrice}\nStock: ${product.stock}'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
