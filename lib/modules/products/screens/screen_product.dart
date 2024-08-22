import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow_mobile/modules/products/api/product_api.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';
import 'package:wareflow_mobile/modules/products/screens/company_type_listing.dart';
import 'package:wareflow_mobile/modules/products/screens/product_type_listing.dart';
import 'package:wareflow_mobile/modules/products/screens/screen_add_product.dart';
import 'package:wareflow_mobile/modules/products/screens/screen_form.dart';
import 'package:wareflow_mobile/modules/products/widget/widget_product_card.dart';
import 'package:wareflow_mobile/widgets/common_textfield.dart';
import 'package:http/http.dart' as http;

class ScreenProducts extends StatefulWidget {
  const ScreenProducts({super.key});

  @override
  State<ScreenProducts> createState() => _ScreenProductsState();
}

class _ScreenProductsState extends State<ScreenProducts> {
  TextEditingController searchController = TextEditingController();
  Future<List<ModelProduct>>? futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = InventoryAPI.getProducts(query: '');
  }

  void _searchProducts(String query) {
    setState(() {
      futureProducts = InventoryAPI.getProducts(query: query);
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('product_type/'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _showForm(BuildContext context, String name, String description) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormScreen(name: name, description: description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Inventory"),
        actions: [
          IconButton(
            icon: const Icon(Icons.data_object),
            onPressed: () async {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                    builder: (context) => const ProductTypeListing()),
              )
                  .then((value) {
                setState(() {});
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.inventory),
            onPressed: () async {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                    builder: (context) => const CompanyTypeListing()),
              )
                  .then((value) {
                setState(() {});
              });
            },
          )
        ],
      ),
      body: Column(
        children: [
          CommonTextfield(
            controller: searchController,
            hintText: 'Search products . . .',
            onChangeValue: (value) {
              _searchProducts(value);
            },
            prefixIcon: PhosphorIcons.magnifyingGlass(),
            onSuffixIconPressed: () {
              searchController.clear();
              _searchProducts('');
            },
            suffixIcon: PhosphorIcons.x(),
          ),
          Expanded(
            child: FutureBuilder<List<ModelProduct>>(
              future: futureProducts,
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (context) => const ScreenAddProduct()),
          )
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
