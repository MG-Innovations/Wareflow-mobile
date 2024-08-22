import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/customers/api.dart';
import 'package:wareflow_mobile/widgets/common_textfield.dart';
import 'package:wareflow_mobile/utils/helper_functions.dart';

class ScreenAddCustomer extends StatefulWidget {
  const ScreenAddCustomer({super.key});

  @override
  State<ScreenAddCustomer> createState() => _ScreenAddCustomerState();
}

class _ScreenAddCustomerState extends State<ScreenAddCustomer> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Customer"),
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
                      label: 'Customer Name',
                      hintText: 'Enter Customer Name',
                      compulsory: true,
                    ),
                    const SizedBox(height: 10),
                    CommonTextfield(
                      controller: numberController,
                      label: 'Customer Number',
                      hintText: 'Enter Customer Email',
                      compulsory: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    CustomerAPI.submitCustomer(
                            customerName: nameController.text,
                            customerNumber: numberController.text)
                        .then((success) {
                      if (success) {
                        Navigator.of(context).pop();
                      } else {
                        HFunctions.showSnackbar(
                          content: 'Failed to add customer',
                          context: context,
                        );
                      }
                    }).catchError((error) {
                      HFunctions.showSnackbar(
                        content: 'Error: $error',
                        context: context,
                      );
                    });
                  }
                },
                child: const Text('+ Add Customer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
