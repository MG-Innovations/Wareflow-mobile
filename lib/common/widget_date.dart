import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WidgetDate extends StatelessWidget {
  final DateTime date;
  const WidgetDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          PhosphorIcons.calendarCheck(),
          size: 16,
        ),
        const SizedBox(width: 5),
        Text(DateFormat("d MMM yy").format(date))
      ],
    );
  }
}
