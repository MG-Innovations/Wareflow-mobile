import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow/modules/dashboard/api/dashboard_api.dart';
import '../../../common/widget_not_found.dart';
import '../../../utils/colors.dart';
import '../../../widgets/common_app_bar.dart';
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
      body: FutureBuilder(
          future: DashboardApi.getAnanlyticsData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: WidgetNotFound(text: "No Data Found"));
            } else {
              final dashboard = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetAnalytics(
                      title: "Total Orders",
                      subTitle: "",
                      icon: PhosphorIcons.coins(),
                      primaryColor: Colors.red,
                      secondaryColor: Colors.red.shade100,
                      value: "${dashboard!.totalOrders}"),
                  const SizedBox(height: 15),
                  WidgetAnalytics(
                      title: "Total Customers",
                      subTitle: "",
                      icon: PhosphorIcons.coins(),
                      primaryColor: Colors.purple,
                      secondaryColor: Colors.purple.shade100,
                      value: "${dashboard.totalCustomers}"),
                  const SizedBox(height: 15),
                  WidgetAnalytics(
                      title: "Total Products",
                      subTitle: "",
                      icon: PhosphorIcons.coins(),
                      primaryColor: Colors.green,
                      secondaryColor: Colors.green.shade100,
                      value: "${dashboard.totalProducts}"),
                  const SizedBox(height: 15),
                  WidgetAnalytics(
                      title: "Remaining Credits",
                      subTitle: "",
                      icon: PhosphorIcons.coins(),
                      primaryColor: Colors.teal,
                      secondaryColor: Colors.teal.shade100,
                      value: "₹${dashboard.remainingMoney}"),
                  const SizedBox(height: 5),
                  const Divider(),
                  const SizedBox(height: 5),
                  const Text("Recent Transactions",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary)),
                  const SizedBox(height: 5),
                  ...snapshot.data!.recentOrders.map(
                    (item) {
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
                  ),
                ],
              );
            }
          }),
    );
  }
}
