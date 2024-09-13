import 'package:chat_app/Servies/auth_servies.dart';
import 'package:chat_app/Views/HomeScreen/homePage.dart';
import 'package:chat_app/Views/auth/sign_in.dart';
import 'package:flutter/material.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthServies.authServies.getCurrentuser()==null?SignIn():HomePage());
  }
}
