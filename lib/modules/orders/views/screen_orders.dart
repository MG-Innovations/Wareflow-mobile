import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/orders/api/orders_api.dart';
import 'package:wareflow_mobile/modules/orders/models/model_order.dart';
import 'package:wareflow_mobile/modules/orders/views/screen_create_order.dart';
import 'package:wareflow_mobile/modules/orders/views/widgets/widget_order_card.dart';

class ScreenOrderListing extends StatelessWidget {
  const ScreenOrderListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Order Listing'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ModelOrder>>(
              future: OrderAPI.getAllOrders(),
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
                        child: WidgetOrderCard(order: item),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ScreenCreateOrder(),
              ),
            );
          }),
    );
  }
}
