import 'package:flutter/material.dart';

class ModelLogin {
  String email;
  String password;

  ModelLogin({
    required this.email,
    required this.password,
  });

  factory ModelLogin.fromJSON(Map<String, dynamic> json) {
    return ModelLogin(email: json['email'], password: json['password']);
  }

  toJSON() {
    return {
      "email": email,
      "password": password,
    };
  }
}
