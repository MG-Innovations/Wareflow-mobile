import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/auth/views/screen_login.dart';
import 'package:wareflow_mobile/modules/home/views/screen_home.dart';
import 'package:wareflow_mobile/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        // textTheme: GoogleFonts.montserratTextTheme().copyWith(),
      ),
      home: ScreenHome(),
    );
  }
}
