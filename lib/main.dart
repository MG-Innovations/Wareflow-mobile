import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modules/auth/views/screen_login.dart';
import '../utils/colors.dart';

SharedPreferences? pref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wareflow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
        // textTheme: GoogleFonts.montserratTextTheme().copyWith(),
      ),
      home: const ScreenLogin(),
    );
  }
}
