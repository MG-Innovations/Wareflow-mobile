import 'package:flutter/material.dart';

import '../../../utils/helper_functions.dart';
import '../../../widgets/common_textfield.dart';
import '../api/product_type_api.dart';

class ScreenAddProductType extends StatefulWidget {
  const ScreenAddProductType({super.key});

  @override
  State<ScreenAddProductType> createState() => _ScreenAddProductTypeState();
}

class _ScreenAddProductTypeState extends State<ScreenAddProductType> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Type'),
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
                      hintText: "Enter product type",
                      compulsory: true,
                    ),
                    const SizedBox(height: 10),
                    CommonTextfield(
                      controller: descriptionController,
                      hintText: "Enter product description",
                      label: 'Product Description',
                      compulsory: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ProductTypeApi.submitProductType(
                              productTypeName: nameController.text,
                              productTypeDescription:
                                  descriptionController.text)
                          .then((value) {
                        if (value) {
                          Navigator.of(context).pop();
                        } else {
                          HFunctions.showSnackbar(
                            content: "Failed to add product Type",
                            context: context,
                          );
                        }
                      });
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
