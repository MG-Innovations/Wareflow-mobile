import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/api.dart';
import 'package:wareflow_mobile/modules/products/model.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  List<ModelProduct> products = [];
  @override
  void initState() {
    super.initState();
    getAllProducts();
  }

  void getAllProducts() async {
    InventoryAPI.getProducts().then((value) {
      setState(() {
        products = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const Text('Products'),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return ListTile(
                title: Text(item.name ?? ""),
                subtitle: const Text('Product Description'),
                trailing: const Text('Price'),
              );
            },
          ),
        ],
      ),
    ));
  }
}
