import 'package:chat_app/Servies/auth_servies.dart';
import 'package:chat_app/Servies/google_auth_servies.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/auth_controller.dart';
import '../auth/sign_in.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(AuthController());
    User? user=AuthServies.authServies.getCurrentuser();
    return Scaffold(
      appBar: AppBar(
        actions: [
          FilledButton(onPressed: () async {
            await AuthServies.authServies.signOut();
            await GoogleAuthService.googleAuthService.signOutFromGoogle();

            Get.to(SignIn());
          }, child: Text('Logout'))
        ],
        title: Text('HomePage'),
      ),
      body: Center(child: Text('${user!.email}',style: TextStyle(fontSize: 35),)),
    );
  }
}
