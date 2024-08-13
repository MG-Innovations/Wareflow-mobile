import 'package:flutter/material.dart';

class WidgetCommonAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool automaticallyImplyLeading;
  const WidgetCommonAppbar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
