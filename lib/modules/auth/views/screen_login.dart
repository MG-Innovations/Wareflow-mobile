import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wareflow_mobile/modules/home/views/screen_home.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      var url = Uri.parse('http://13.233.100.211:8000/api/v1/user/login');

      try {
        var requestBody = jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        });

        print('Request URL: $url');
        print('Request Body: $requestBody');

        var response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: requestBody,
        );

        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);

          String? accessToken = jsonResponse['data']?['access_token'];

          if (accessToken != null && accessToken.isNotEmpty) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('accessToken', accessToken);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ScreenHome()),
            );
            print('Login successful: $jsonResponse');
          } else {
            print('Access token is missing from the response.');
            _showErrorDialog('Login failed. Access token is missing.');
          }
        } else {
          print('Login Failed: ${response.body}');
          _showErrorDialog('Login failed. Please check your credentials.');
        }
      } catch (e) {
        print('Error: $e');
        _showErrorDialog('An error occurred. Please try again.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
