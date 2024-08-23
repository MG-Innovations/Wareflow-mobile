import 'package:flutter/material.dart';
import '../utils/enums.dart';
import '../utils/helper_functions.dart';

class WidgetChip extends StatelessWidget {
  final Color primary;
  final Color secondary;
  final EnumChipType chipType;
  const WidgetChip(
      {super.key,
      required this.primary,
      required this.secondary,
      required this.chipType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: secondary,
        border: Border.all(color: primary),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(width: 5),
          Text(
            HFunctions.getChipText(type: chipType),
            style: TextStyle(
                color: primary, fontWeight: FontWeight.bold, fontSize: 12),
          )
        ],
      ),
    );
  }
}
