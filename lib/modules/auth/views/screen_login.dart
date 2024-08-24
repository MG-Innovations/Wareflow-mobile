import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../../utils/helper_functions.dart';
import '../../../widgets/common_textfield.dart';
import '../../home/views/screen_home.dart';
import '../api/auth_api.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() {
    if (pref!.getString('auth_token') != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ScreenHome()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: (isLoading)
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text(
                      "WAREFLOW",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CommonTextfield(
                      controller: emailController,
                      label: "Email",
                      hintText: "Enter your email address",
                      regex: r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                      compulsory: true,
                    ),
                    const SizedBox(height: 20),
                    CommonTextfield(
                      controller: passwordController,
                      label: "Password",
                      hintText: "Enter your email address",
                      compulsory: true,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      AuthAPI.loginUser(
              email: emailController.text, password: passwordController.text)
          .then((value) {
        if (value != null) {
          pref!.setString('auth_token', value);
          HFunctions.showSnackbar(
              context: context, content: "Login Successfully");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const ScreenHome()));
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          HFunctions.showSnackbar(
              context: context, content: "Error logging in");
        }
      });
    }
  }
}
