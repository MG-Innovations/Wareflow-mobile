import 'package:flutter/material.dart';
import 'package:wareflow/common/widget_not_found.dart';

import '../api/product_type_api.dart';
import '../widget/widget_product_type_card.dart';
import 'screen_add_product_type.dart';

class ProductTypeListing extends StatefulWidget {
  const ProductTypeListing({super.key});

  @override
  State<ProductTypeListing> createState() => _ProductTypeListingState();
}

class _ProductTypeListingState extends State<ProductTypeListing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: ProductTypeApi.getProductsType(query: ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: WidgetNotFound(text: 'No Products Type Found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: WidgetProductTypeCard(productType: item),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
                builder: (context) => const ScreenAddProductType()),
          )
              .then((Value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
