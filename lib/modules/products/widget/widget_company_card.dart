import 'package:flutter/material.dart';

import '../models/model_product.dart';

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
      child: ListTile(
        title: Text(
          companyType.name ?? "NA",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text((companyType.email != "") ? companyType.email ?? "NA" : "NA"),
            const SizedBox(width: 10),
            Text((companyType.phoneNumber != "")
                ? companyType.phoneNumber ?? "NA"
                : "NA")
          ],
        ),
      ),
    );
  }
}
