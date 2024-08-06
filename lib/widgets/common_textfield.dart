import 'package:flutter/material.dart';

class CommonTextfield extends StatefulWidget {
  final TextEditingController controller;
  const CommonTextfield({super.key, required this.controller});

  @override
  State<CommonTextfield> createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: const InputDecoration(
        hintText: 'Enter text',
      ),
    );
  }
}
