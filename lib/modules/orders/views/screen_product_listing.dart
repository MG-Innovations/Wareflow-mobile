import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow_mobile/modules/products/api/product_api.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';
import 'package:wareflow_mobile/modules/products/widget/widget_product_card.dart';
import 'package:wareflow_mobile/widgets/common_textfield.dart';

class ScreenProductListing extends StatefulWidget {
  final Function(List<ModelProduct> productListing) onProductSelected;
  final List<ModelProduct> selectedProduct;
  const ScreenProductListing(
      {super.key,
      required this.onProductSelected,
      required this.selectedProduct});

  @override
  State<ScreenProductListing> createState() => _ScreenProductListingState();
}

class _ScreenProductListingState extends State<ScreenProductListing> {
  TextEditingController searchController = TextEditingController();
  Future<List<ModelProduct>>? futureProducts;
  List<ModelProduct> selectedProducts = [];

  @override
  void initState() {
    super.initState();
    futureProducts = InventoryAPI.getProducts(query: '');
    selectedProducts = widget.selectedProduct;
  }

  void _searchProducts(String query) {
    setState(() {
      futureProducts = InventoryAPI.getProducts(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Inventory'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              widget.onProductSelected(selectedProducts);
              Navigator.pop(context);
            },
            icon: Icon(PhosphorIcons.check()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...selectedProducts.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Chip(
                            label: Text(e.name!),
                            onDeleted: () {
                              setState(() {
                                selectedProducts.remove(e);
                              });
                            },
                          ),
                        );
                      })
                    ],
                  )),
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
                        final selected = selectedProducts
                            .where((test) => test.id == item.id)
                            .isNotEmpty;
                        return GestureDetector(
                          onTap: () {
                            if (!selected) {
                              setState(() {
                                selectedProducts.add(item);
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: WidgetProductCard(
                              product: item,
                              selected: selected,
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
