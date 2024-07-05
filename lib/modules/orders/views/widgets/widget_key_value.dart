import 'package:flutter/material.dart';

class WidgetKeyValue extends StatelessWidget {
  final String keyString;
  final String value;
  const WidgetKeyValue(
      {super.key, required this.keyString, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          keyString,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(width: 5),
        const Text(':',
            style:  TextStyle(fontSize: 14, color: Colors.black)),
        const SizedBox(width: 5),
        Text(
          value,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        )
      ],
    );
  }
}
