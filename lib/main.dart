import 'package:flutter/material.dart';
import 'package:wareflow_mobile/modules/home/views/screen_home.dart';
import 'package:wareflow_mobile/utils/colors.dart';

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
      home: ScreenLogin(),
    );
  }
}


// body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text('Login'),
      //       const TextField(
      //         decoration: InputDecoration(
      //           hintText: 'Username',
      //         ),
      //       ),
      //       const TextField(
      //         decoration: InputDecoration(
      //           hintText: 'Password',
      //         ),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {},
      //         child: const Text('Login'),
      //       ),
      //     ],
      //   ),
      // ),