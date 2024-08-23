import 'package:flutter/material.dart';

import 'widget_icon.dart';

class WidgetAnalytics extends StatelessWidget {
  final String title;
  final String subTitle;
  final String value;
  final IconData icon;
  final Color primaryColor;
  final Color secondaryColor;
  const WidgetAnalytics(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon,
      required this.primaryColor,
      required this.secondaryColor,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primaryColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    WidgetIcon(
                      icon: icon,
                      primary: primaryColor,
                      secondary: secondaryColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              subTitle,
              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
    );
  }
}
