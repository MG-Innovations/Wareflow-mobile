import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/customers/api/customer_api.dart';
import 'package:wareflow_mobile/modules/customers/models/model_customer.dart';
import 'package:wareflow_mobile/modules/customers/screens/screen_add_customer.dart';
import 'package:wareflow_mobile/modules/customers/views/widgets/widget_customer_card.dart';
import 'package:wareflow_mobile/modules/products/screens/screen_add_product.dart';
import 'package:wareflow_mobile/widgets/common_app_bar.dart';

class ScreenCustomers extends StatefulWidget {
  const ScreenCustomers({super.key});

  @override
  State<ScreenCustomers> createState() => _ScreenCustomersState();
}

class _ScreenCustomersState extends State<ScreenCustomers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetCommonAppbar(title: "Inventory"),
      body: FutureBuilder<List<ModelCustomer>>(
        future: CustomerApi.getAllCustomers(),
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
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: WidgetCustomerCard(customer: item),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(builder: (context) => const ScreenAddCustomer()),
          )
              .then((Value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
