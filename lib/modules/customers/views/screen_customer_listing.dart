import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow_mobile/modules/customers/api/customer_api.dart';
import 'package:wareflow_mobile/modules/customers/models/model_customer.dart';
import 'package:wareflow_mobile/modules/customers/views/widgets/widget_customer_card.dart';
import 'package:wareflow_mobile/widgets/common_app_bar.dart';
import 'package:wareflow_mobile/widgets/common_textfield.dart';

class ScreenCustomers extends StatefulWidget {
  const ScreenCustomers({super.key});

  @override
  State<ScreenCustomers> createState() => _ScreenCustomersState();
}

class _ScreenCustomersState extends State<ScreenCustomers> {
  TextEditingController searchController = TextEditingController();
  Future<List<ModelCustomer>>? futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = CustomerApi.getAllCustomers(query: '');
  }

  void _searchProducts(String query) {
    setState(() {
      futureProducts = CustomerApi.getAllCustomers(query: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetCommonAppbar(title: "Customer"),
      body: Column(
        children: [
          CommonTextfield(
            controller: searchController,
            hintText: 'Search products . . .',
            onChangeValue: (value) {
              _searchProducts(value);
            },
            prefixIcon: PhosphorIcons.magnifyingGlass(),
            onSuffixIconPressed: () {
              searchController.clear();
              _searchProducts('');
            },
            suffixIcon: PhosphorIcons.x(),
          ),
          Expanded(
            child: FutureBuilder<List<ModelCustomer>>(
              future: futureProducts,
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context)
          //     .push(
          //   MaterialPageRoute(builder: (context) => const ScreenAddProduct()),
          // )
          //     .then((value) {
          //   setState(() {});
          // });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
