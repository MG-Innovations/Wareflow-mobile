import 'package:flutter/material.dart';
import 'package:wareflow/modules/products/screens/screen_product_listing.dart';

import 'company_type_listing.dart';
import 'product_type_listing.dart';

class ScreenInventory extends StatefulWidget {
  const ScreenInventory({super.key});

  @override
  State<ScreenInventory> createState() => _ScreenInventoryState();
}

class _ScreenInventoryState extends State<ScreenInventory>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            TabBar(controller: tabController, tabs: const [
              Tab(text: "Products"),
              Tab(text: "Type"),
              Tab(text: "Company"),
            ]),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  ScreenProducts(),
                  ProductTypeListing(),
                  CompanyTypeListing()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
