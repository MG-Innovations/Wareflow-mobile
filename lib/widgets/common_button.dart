import 'package:flutter/material.dart';

class PackageButtonController {
  VoidCallback? success;
  VoidCallback? reset;
  VoidCallback? error;
  VoidCallback? loading;

  void dispose() {
    success = null;
    reset = null;
    error = null;
    loading = null;
  }
}

class CommonButton extends StatefulWidget {
  final String label;
  final PackageButtonController? controller;
  const CommonButton(
      {super.key, required this.label, required this.controller});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  PackageButtonController? controller;
  bool isPressed = false;
  bool isErrorOccured = false;
  bool isSuccess = false;

  @override
  void initState() {
    super.initState();

    controller = widget.controller;
    if (controller != null) {
      controller!.loading = loading;
      controller!.success = success;
      controller!.reset = reset;
      controller!.error = error;
    }
  }

  success() {
    setState(() {
      isSuccess = true;
      isErrorOccured = false;
      isPressed = false;
    });
  }

  loading() {
    setState(() {
      isPressed = true;
      isErrorOccured = false;
      isSuccess = false;
    });
  }

  reset() {
    setState(() {
      isPressed = false;
      isErrorOccured = false;
      isSuccess = false;
    });
  }

  error() {
    setState(() {
      isPressed = false;
      isErrorOccured = true;
      isSuccess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        child: const Text('Login'),
      ),
    );
  }
}
