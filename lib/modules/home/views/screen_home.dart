import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:wareflow_mobile/modules/customers/views/screen_customer_listing.dart';
import 'package:wareflow_mobile/modules/dashboard/views/screen_dashboard.dart';
import 'package:wareflow_mobile/modules/profile/widget/user_profile.dart';
import 'package:wareflow_mobile/modules/orders/views/screen_orders.dart';
import 'package:wareflow_mobile/modules/products/screens/screen_product.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Expanded(
                child: TabBarView(controller: tabController, children: const [
              ScreenDashboard(),
              ScreenProducts(),
              ScreenCustomers(),
              ScreenOrderListing(),
              UserProfile(
                userId: '',
              )
            ]))
          ],
        ),
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(
            fontSize: 12.0, fontFamily: GoogleFonts.montserrat().fontFamily),
        labelPadding: EdgeInsets.zero,
        tabs: [
          Tab(
            icon: Icon(PhosphorIcons.squaresFour()),
            text: 'Home',
          ),
          Tab(
            icon: Icon(PhosphorIcons.package()),
            text: 'Inventory',
          ),
          Tab(
            icon: Icon(PhosphorIcons.users()),
            text: 'Customers',
          ),
          Tab(
            icon: Icon(PhosphorIcons.currencyInr()),
            text: 'Orders',
          ),
          Tab(
            icon: Icon(PhosphorIcons.userCircle()),
            text: 'Profile',
          )
        ],
      ),
    );
  }
}
