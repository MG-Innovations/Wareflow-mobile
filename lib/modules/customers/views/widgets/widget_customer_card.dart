import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../common/widget_icon_value.dart';

class WidgetCustomerCard extends StatelessWidget {
  const WidgetCustomerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Customer 1',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              WidgetIconValue(
                  primaryColor: Colors.green.shade400,
                  iconData: PhosphorIcons.arrowCircleDownLeft(
                      PhosphorIconsStyle.fill),
                  value: "\$20,000"),
            ],
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetIconValue(
                  iconData: PhosphorIcons.phoneCall(), value: "+91 9420486908"),
              const SizedBox(height: 5),
              WidgetIconValue(
                  iconData: PhosphorIcons.mapPinArea(),
                  value: "Ashoka Marg Nashik"),
            ],
          ),
        ],
      ),
    );
  }
}
