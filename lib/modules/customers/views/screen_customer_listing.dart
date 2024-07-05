import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/customers/views/widgets/widget_customer_card.dart';

import '../../../common/widget_button.dart';

class ScreenCustomerListing extends StatelessWidget {
  const ScreenCustomerListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Listing'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            WidgetCustomerCard(),
            SizedBox(height: 10),
            WidgetCustomerCard(),
            SizedBox(height: 10),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: WidgetButton(
        title: "+ Customer",
        width: 120,
        onPressed: () {},
      ),
    );
  }
}
