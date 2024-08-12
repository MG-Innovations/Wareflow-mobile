import 'package:flutter/material.dart';
import 'package:wareflow_mobile/widgets/common_textfield.dart';

class ScreenAddProduct extends StatefulWidget {
  const ScreenAddProduct({super.key});

  @override
  State<ScreenAddProduct> createState() => _ScreenAddProductState();
}

class _ScreenAddProductState extends State<ScreenAddProduct> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController buyingPriceController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [CommonTextfield(controller: nameController)],
          ),
        ));
  }
}
