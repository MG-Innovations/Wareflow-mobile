import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/products/models/model_product.dart';

class WidgetCompanyTypeCard extends StatelessWidget {
  final CompanyType companyType;
  const WidgetCompanyTypeCard({super.key, required this.companyType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(companyType.name ?? ''),
            const SizedBox(height: 8),
            Text(companyType.email ?? ''),
            const SizedBox(height: 8),
            Text(companyType.phoneNumber ?? ''),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    ;
  }
}
