import 'package:flutter/material.dart';

import '../../../utils/helper_functions.dart';
import '../../../widgets/common_textfield.dart';
import '../api/company_type_api.dart';

class ScreenAddCompanyType extends StatefulWidget {
  const ScreenAddCompanyType({super.key});

  @override
  State<ScreenAddCompanyType> createState() => _ScreenAddCompanyTypeState();
}

class _ScreenAddCompanyTypeState extends State<ScreenAddCompanyType> {
  final TextEditingController idController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Company Type'),
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
                      label: 'Company Name',
                      hintText: "Enter Company Name",
                      compulsory: true,
                    ),
                    const SizedBox(height: 20),
                    CommonTextfield(
                      controller: emailController,
                      label: 'Company Email',
                      hintText: "Enter company Email",
                    ),
                    const SizedBox(height: 20),
                    CommonTextfield(
                      controller: phoneNumberController,
                      hintText: "Enter company Phone Number",
                      label: 'Phone Number',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      CompanyTypeApi.submitCompanyType(
                              companyName: nameController.text,
                              companyEmail: emailController.text,
                              companyPhonenumber: phoneNumberController.text)
                          .then((value) {
                        if (value) {
                          Navigator.of(context).pop();
                        } else {
                          HFunctions.showSnackbar(
                            content: "Failed to add Company Type",
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
