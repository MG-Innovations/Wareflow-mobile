import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../utils/helper_functions.dart';
import '../../../widgets/common_app_bar.dart';
import '../../../widgets/common_textfield.dart';
import '../../customers/api/customer_api.dart';
import '../../products/models/model_product.dart';
import '../api/orders_api.dart';
import 'screen_product_listing.dart';

class ModelProductTableItem {
  final ModelProduct product;
  int quantity;
  double cost;

  ModelProductTableItem({
    required this.product,
    this.quantity = 1,
    this.cost = 0.0,
  });
}

class ScreenCreateOrder extends StatefulWidget {
  const ScreenCreateOrder({super.key});

  @override
  State<ScreenCreateOrder> createState() => _ScreenCreateOrderState();
}

class _ScreenCreateOrderState extends State<ScreenCreateOrder> {
  List<ModelProduct> products = [];
  List<ModelProductTableItem> productTableItems = [];

  final TextEditingController productNameController =
      TextEditingController(text: "Tap to add products");

  final TextEditingController customerController = TextEditingController();
  final TextEditingController totalPriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Map to track if the quantity exceeds for each product
  Map<String, bool> quantityExceeded = {};

  ModelDropdown? customer;

  // Discount options: % or direct value
  DiscountType? discountType = DiscountType.none;

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetCommonAppbar(title: "Create Order"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextfield(
                controller: customerController,
                label: 'Select Customer',
                type: FieldType.dropdown,
                hintText: 'Select Customer',
                searchInNetwork: true,
                fetchDropdown: CustomerApi.getAllCustomersDropdown(query: ''),
                onSelectDropdown: (item) {
                  customerController.text = item.name;
                  customer = item;
                },
              ),
              const SizedBox(height: 20),
              CommonTextfield(
                controller: productNameController,
                label: 'Select Products',
                type: FieldType.dropdown,
                hintText: 'Select Products',
                searchInNetwork: true,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => ScreenProductListing(
                      selectedProduct: products,
                      onProductSelected: (selectedProducts) {
                        setState(() {
                          products = selectedProducts;
                          productTableItems = products
                              .map((e) => ModelProductTableItem(
                                    product: e,
                                    cost: e.sellingPrice!,
                                  ))
                              .toList();
                          // Reset quantity exceeded status
                          quantityExceeded.clear();
                        });
                      },
                    ),
                  ));
                },
              ),
              const SizedBox(height: 20),
              productTableItems.isNotEmpty
                  ? Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 20.0,
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Product',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Quantity',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Cost',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                          ],
                          rows: productTableItems.map((productTableItem) {
                            return DataRow(cells: [
                              DataCell(Text(productTableItem.product.name!,
                                  style: TextStyle(
                                    color: quantityExceeded[
                                                productTableItem.product.id!] ??
                                            false
                                        ? Colors.red
                                        : Colors.black,
                                  ))),
                              DataCell(
                                TextFormField(
                                  initialValue:
                                      productTableItem.quantity.toString(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: quantityExceeded[productTableItem
                                                    .product.id!] ??
                                                false
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                  onChanged: (value) {
                                    int quantity = int.tryParse(value) ?? 0;
                                    productTableItem.quantity = quantity;
                                    if (quantity >
                                        productTableItem.product.stock!) {
                                      quantityExceeded[
                                          productTableItem.product.id!] = true;
                                    } else {
                                      quantityExceeded[
                                          productTableItem.product.id!] = false;
                                    }
                                    log("quantityExceeded : ${quantityExceeded[productTableItem.product.id]}");
                                    handlePriceQuantityChange();
                                    setState(() {});
                                  },
                                ),
                              ),
                              DataCell(
                                TextFormField(
                                  initialValue:
                                      productTableItem.cost.toString(),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(8),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      productTableItem.cost =
                                          double.parse(value);
                                    });
                                    handlePriceQuantityChange();
                                  },
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    )
                  : const Center(child: Text('No products added yet')),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<DiscountType>(
                      title: const Text('Percentage (%)'),
                      value: DiscountType.percentage,
                      groupValue: discountType,
                      onChanged: (DiscountType? value) {
                        setState(() {
                          discountType = value;
                          applyDiscount();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<DiscountType>(
                      title: const Text('Direct (₹)'),
                      value: DiscountType.direct,
                      groupValue: discountType,
                      onChanged: (DiscountType? value) {
                        setState(() {
                          discountType = value;
                          applyDiscount();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CommonTextfield(
                controller: discountController,
                label: 'Discount',
                type: FieldType.text,
                hintText: 'Discount',
                regex: "^[0-9]*\$",
                keyboardType: TextInputType.number,
                onChangeValue: (value) {
                  if (discountType == DiscountType.percentage) {
                    final discount = double.parse(value);
                    if (discount > 100) {
                      discountController.text = '100';
                    }
                  }
                  applyDiscount();
                },
              ),
              const SizedBox(height: 10),
              CommonTextfield(
                controller: totalPriceController,
                label: 'Total Price',
                type: FieldType.text,
                hintText: 'Total Price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createOrder();
                  }
                },
                child: const Text('Make Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createOrder() {
    setState(() {
      loading = true;
    });

    OrderAPI.createOrder(
            customerId: customer!.id,
            products: productTableItems,
            totalPrice: totalPriceController.text)
        .then((value) {
      setState(() {
        loading = false;
      });
      if (value) {
        // Order created successfully
        HFunctions.showSnackbar(
            context: context, content: "Order created successfully");
        Navigator.pop(context);
      } else {
        // Order creation failed
        HFunctions.showSnackbar(
            context: context, content: "Order creation failed");
      }
    });
  }

  void handlePriceQuantityChange() {
    double totalPrice = 0.0;
    productTableItems.forEach((element) {
      totalPrice += element.cost * element.quantity;
    });
    totalPriceController.text = totalPrice.toString();
    applyDiscount(); // Ensure discount is applied after price change
  }

  void applyDiscount() {
    double discount = double.tryParse(discountController.text) ?? 0.0;
    double totalPrice = productTableItems.fold(
        0.0, (sum, item) => sum + (item.cost * item.quantity));

    if (discountType == DiscountType.percentage) {
      totalPrice -= (totalPrice * discount) / 100;
    } else if (discountType == DiscountType.direct) {
      totalPrice -= discount;
    }

    totalPriceController.text = totalPrice.toStringAsFixed(2);
  }
}

enum DiscountType { none, percentage, direct }
