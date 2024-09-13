import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/Views/auth/sign_in.dart';
import 'package:chat_app/Views/auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/splashScreen/bg.jpg'),fit: BoxFit.cover)
          ),
          child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
            Spacer(),
            Text('Welcome Back!',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
            SizedBox(height: 20,),
            Text('Enter personal details to your\nemployee account',style: TextStyle(color: Colors.blue.shade100,fontWeight: FontWeight.w500,fontSize: 20),textAlign: TextAlign.center,),
            Spacer(),
            Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              SizedBox(width: 15,),
              GestureDetector(onTap:(){
                Get.to(SignIn());
              },child: Text('Sign in',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
              GestureDetector(
                onTap: (){
                  Get.to(SignUp());
                },
                child: Container(
                  height: 80,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(45),)
                  ),
                  alignment: Alignment.center,
                  child: Text('Sign up',style: TextStyle(color: Colors.lightBlue,fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
            ],)
          ],),
        )
      ],)
    );
  }
}
