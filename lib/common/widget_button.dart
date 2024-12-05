import 'package:flutter/material.dart';

import '../utils/colors.dart';

class WidgetButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final Function() onPressed;
  const WidgetButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.height = 30,
      this.width = 100});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
