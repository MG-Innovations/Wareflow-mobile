import 'package:flutter/material.dart';

class WidgetIconValue extends StatelessWidget {
  final IconData iconData;
  final String value;
  final double iconSize;
  final double fontSize;
  final Color primaryColor;
  const WidgetIconValue(
      {super.key,
      required this.iconData,
      required this.value,
      this.iconSize = 16,
      this.fontSize = 14,
      this.primaryColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: iconSize,
          color: primaryColor,
          weight: 20,
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w700,
              color: primaryColor),
        )
      ],
    );
  }
}
