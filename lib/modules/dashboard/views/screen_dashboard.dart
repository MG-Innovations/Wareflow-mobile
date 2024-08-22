import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow_mobile/modules/dashboard/views/widgets/widget_analytic.dart';
import 'package:wareflow_mobile/utils/colors.dart';
import 'package:wareflow_mobile/widgets/common_app_bar.dart';

class ScreenDashboard extends StatelessWidget {
  const ScreenDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WidgetCommonAppbar(
        title: "Dashboard",
      ),
      body: SingleChildScrollView(
        child: Column(
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
            // const WidgetOrderCard(),
            // const SizedBox(height: 15),
            // const WidgetOrderCard(),
            // const SizedBox(height: 15),
            // const WidgetOrderCard()
          ],
        ),
      ),
    );
  }
}
