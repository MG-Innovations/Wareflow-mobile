import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/api/product_type_api.dart';
import 'package:wareflow_mobile/modules/products/screens/product_type_form_screen.dart';
import 'package:wareflow_mobile/modules/products/widget/widget_product_type_card.dart';

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
      appBar: AppBar(
        title: const Text('Product Type List'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder(
          future: ProductTypeApi.getProductsType(query: ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No products type found'));
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
