import 'package:flutter/material.dart';
import 'package:wareflow/common/widget_not_found.dart';
import 'package:wareflow/modules/products/screens/screen_add_company.dart';

import '../api/company_type_api.dart';
import '../widget/widget_company_card.dart';

class CompanyTypeListing extends StatefulWidget {
  const CompanyTypeListing({super.key});

  @override
  State<CompanyTypeListing> createState() => _CompanyTypeListingState();
}

class _CompanyTypeListingState extends State<CompanyTypeListing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: CompanyTypeApi.getCompanysType(query: ''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: WidgetNotFound(text: 'No Customer Found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: WidgetCompanyTypeCard(companyType: item),
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
            MaterialPageRoute(
                builder: (context) => const ScreenAddCompanyType()),
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
