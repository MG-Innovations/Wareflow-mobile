import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/api/product_api.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';
import 'package:wareflow_mobile/modules/products/screens/screen_add_product.dart';
import 'package:wareflow_mobile/modules/products/widget/widget_product_card.dart';
import 'package:wareflow_mobile/widgets/common_app_bar.dart';

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetCommonAppbar(title: "Inventory"),
      body: FutureBuilder<List<ModelProduct>>(
        future: InventoryAPI.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: WidgetProductCard(product: item),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScreenAddProduct()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
