import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow/common/widget_not_found.dart';
import 'package:wareflow/utils/dio.dart';
import '../../../widgets/common_textfield.dart';
import '../api/product_api.dart';
import '../models/model_product.dart';
import '../widget/widget_product_card.dart';
import 'company_type_listing.dart';
import 'product_type_listing.dart';
import 'screen_add_product.dart';
import 'screen_form.dart';

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
    final response = await dioClient.get('product_type/');

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
                  return const Center(
                      child: WidgetNotFound(text: "No Products Found"));
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
            _searchProducts(searchController.text);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
