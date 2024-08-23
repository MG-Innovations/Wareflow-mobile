import 'package:flutter/material.dart';

class WidgetNotFound extends StatelessWidget {
  final String text;
  const WidgetNotFound({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "asset/icons/not_found.png",
          height: 150,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
