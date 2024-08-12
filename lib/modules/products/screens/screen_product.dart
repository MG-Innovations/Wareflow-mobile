import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/api.dart';
import 'package:wareflow_mobile/modules/products/model.dart';
import 'package:wareflow_mobile/modules/products/screens/screen_add_product.dart';
import 'package:wareflow_mobile/modules/products/widget/widget_product_card.dart';

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
            ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final item = products[index];
                return WidgetProductCard(product: item);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ScreenAddProduct()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
