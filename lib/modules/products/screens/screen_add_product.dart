import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/api.dart';
import 'package:wareflow_mobile/utils/helper_functions.dart';
import 'package:wareflow_mobile/widgets/common_app_bar.dart';
import 'package:wareflow_mobile/widgets/common_textfield.dart';

class ScreenAddProduct extends StatefulWidget {
  const ScreenAddProduct({super.key});

  @override
  State<ScreenAddProduct> createState() => _ScreenAddProductState();
}

class _ScreenAddProductState extends State<ScreenAddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController productTypeController = TextEditingController();
  final TextEditingController productCompanyController =
      TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController buyingPriceController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController initialStockController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  ModelDropdown? productType, company;

  List<ModelDropdown> productTypes = [], companyList = [];

  @override
  void initState() {
    super.initState();
    getLists();
  }

  getLists() {
    InventoryAPI.getAllCompany().then((value) {
      log(value.toString());
      companyList = value;
    });

    InventoryAPI.getAllProductType().then((value) {
      log(value.toString());
      productTypes = value;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const WidgetCommonAppbar(
          title: "Add Product",
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CommonTextfield(
                        controller: nameController,
                        label: 'Product Name',
                        hintText: "Enter product name",
                        compulsory: true,
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: descriptionController,
                        hintText: "Enter product description",
                        label: 'Product Description',
                        compulsory: true,
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: productTypeController,
                        label: 'Product Type',
                        hintText: "Select product type",
                        type: FieldType.dropdown,
                        dropdownList: [...productTypes],
                        compulsory: true,
                        onSelectDropdown: (item) {
                          productTypeController.text = item.name;
                          productType = item;
                        },
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: productCompanyController,
                        label: 'Product Company',
                        hintText: "Select product company",
                        type: FieldType.dropdown,
                        dropdownList: [...companyList],
                        compulsory: true,
                        onSelectDropdown: (item) {
                          productCompanyController.text = item.name;
                          company = item;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextfield(
                              controller: sellingPriceController,
                              label: 'Selling Price',
                              hintText: "Enter selling price",
                              compulsory: true,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CommonTextfield(
                              controller: buyingPriceController,
                              label: 'Buying Price',
                              hintText: "Enter buying price",
                              compulsory: true,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CommonTextfield(
                        controller: initialStockController,
                        label: 'Initial stock',
                        hintText: "Enter initial stock",
                        compulsory: true,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      InventoryAPI.submitProduct(
                              producName: nameController.text,
                              productDescription: descriptionController.text,
                              productTypeId: productType!.id,
                              productCompanyNameId: company!.id,
                              sellingPrice: sellingPriceController.text,
                              buyingPrice: buyingPriceController.text,
                              initialStock: initialStockController.text)
                          .then((value) {
                        if (value) {
                          Navigator.of(context).pop();
                        } else {
                          HFunctions.showSnackbar(
                            content: "Failed to add product",
                            context: context,
                          );
                        }
                      });
                    }
                  },
                  child: const Text("+ Add Product"),
                )
              ],
            ),
          ),
        ));
  }
}
