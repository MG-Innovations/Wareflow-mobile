import 'package:flutter/material.dart';

class WidgetIcon extends StatelessWidget {
  final IconData icon;
  final Color primary;
  final Color secondary;
  const WidgetIcon(
      {super.key,
      required this.icon,
      required this.primary,
      required this.secondary});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 20,
          color: primary,
        ));
  }
}
