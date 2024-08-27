import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../common/widget_not_found.dart';
import '../../../utils/colors.dart';
import '../../../widgets/common_app_bar.dart';
import '../../orders/api/orders_api.dart';
import '../../orders/models/model_order.dart';
import '../../orders/views/screen_order_details.dart';
import '../../orders/views/widgets/widget_order_card.dart';
import 'widgets/widget_analytic.dart';

class ScreenDashboard extends StatelessWidget {
  const ScreenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetCommonAppbar(
        title: "Dashboard",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetAnalytics(
              title: "Total Revenue",
              subTitle: "ABC corporation purchased the most goods this year",
              icon: PhosphorIcons.coins(),
              primaryColor: Colors.red,
              secondaryColor: Colors.red.shade100,
              value: "\$20000"),
          const SizedBox(height: 15),
          WidgetAnalytics(
              title: "Total Revenue",
              subTitle: "ABC corporation purchased the most goods this year",
              icon: PhosphorIcons.coins(),
              primaryColor: Colors.purple,
              secondaryColor: Colors.purple.shade100,
              value: "\$20000"),
          const SizedBox(height: 15),
          WidgetAnalytics(
              title: "Total Revenue",
              subTitle: "ABC corporation purchased the most goods this year",
              icon: PhosphorIcons.coins(),
              primaryColor: Colors.green,
              secondaryColor: Colors.green.shade100,
              value: "\$20000"),
          const SizedBox(height: 15),
          WidgetAnalytics(
              title: "Total Revenue",
              subTitle: "ABC corporation purchased the most goods this year",
              icon: PhosphorIcons.coins(),
              primaryColor: Colors.teal,
              secondaryColor: Colors.teal.shade100,
              value: "\$20000"),
          const SizedBox(height: 5),
          const Divider(),
          const SizedBox(height: 5),
          const Text("Recent Transactions",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary)),
          const SizedBox(height: 5),
          Expanded(
            child: FutureBuilder<List<ModelOrder>>(
              future: OrderAPI.getWeeklyOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: WidgetNotFound(text: "No Orders Found"));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: InkWell(
                            onTap: () {
                              if (item.balance > 0) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) =>
                                        ScreenOrderDetails(order: item)))
                                    .then((value) {});
                              }
                            },
                            child: WidgetOrderCard(order: item),
                          ));
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
