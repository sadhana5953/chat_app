import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/Model/user_model.dart';
import 'package:chat_app/Servies/cloud_firestore_servies.dart';
import 'package:chat_app/Views/HomeScreen/homePage.dart';
import 'package:chat_app/Views/auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../Servies/auth_servies.dart';
import '../../Servies/google_auth_servies.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
     double height = MediaQuery.of(context).size.height;
     double width = MediaQuery.of(context).size.width;
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/splashScreen/bg.jpg'),fit: BoxFit.cover)
    ),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              children: [
                IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,)),
                Text('Back',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: height*0.800,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35),),
        ),
        child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
          SizedBox(height: 30,),
          Text('Get Started',style: TextStyle(color: Color(0xff3f6edb),fontWeight: FontWeight.bold,fontSize: 35),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 25),
            child: TextField(
              controller: controller.txtName,
              decoration: InputDecoration(
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 25),
            child: TextField(
              controller: controller.txtPhone,
              decoration: InputDecoration(
                  hintText: 'Enter Phone number',
                  hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 25),
            child: TextField(
              controller: controller.txtEmail,
              decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 25),
            child: TextField(
              controller: controller.txtPassword,
              decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 25),
            child: TextField(
              controller: controller.txtConfirmPassword,
              decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black54),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  )),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.to(SignIn());
              },
              child: RichText(text: TextSpan(children: [
                TextSpan(
                  text: 'Already have account? ',
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' Sign In',
                  style: TextStyle(color: Color(0xff3f6edb),fontWeight: FontWeight.bold),
                ),
              ]))),
          GestureDetector(
              onTap: () async {
                if (controller.txtPassword.text ==
                    controller.txtConfirmPassword.text) {
                  String resopnse = await AuthServies.authServies
                      .createAccountWithEmailAndPassword(
                      controller.txtEmail.text,
                      controller.txtPassword.text);
                  User? user = AuthServies.authServies.getCurrentuser();
                  UserModel users = UserModel(
                      name: controller.txtName.text,
                      email: controller.txtEmail.text,
                      image: "https://writestylesonline.com/wp-content/uploads/2018/11/Three-Statistics-That-Will-Make-You-Rethink-Your-Professional-Profile-Picture-1024x1024.jpg",
                      phone: controller.txtPhone.text,
                      token: "------");
                  CloudFireStoreService.cloudFireStoreService
                      .insertUserIntoFireStore(users);
                  Get.off(HomePage());
                  controller.txtPassword.clear();
                  controller.txtEmail.clear();
                  controller.txtName.clear();
                  controller.txtConfirmPassword.clear();
                  controller.txtPhone.clear();
                }
              },
              child: Container(
                height: height*0.065,
                width: width*0.900,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.black45,spreadRadius: 1,blurRadius: 8,offset: Offset(2, 4)),
                  ],
                  color: Color(0xff3f6edb),
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text('Sign up',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
              )),
          Spacer(),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 40,right: 10),  // Margin around the divider
                height: height*0.001,  // Height of the divider (thickness)
                width: width*0.280,  // Full width of the parent
                color: Colors.black45,  // Color of the divider
              ),
              Text('Sign up with',style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold),),
              Container(
                margin: EdgeInsets.only(left: 10,right: 40),  // Margin around the divider
                height: height*0.001,  // Height of the divider (thickness)
                width: width*0.280,  // Full width of the parent
                color: Colors.black45,  // Color of the divider
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SignInButton(Buttons.facebook,mini: true, onPressed: (){}),
              SignInButton(Buttons.twitter,mini: true, onPressed: (){}),
              GestureDetector(
                onTap: () async {
                  await GoogleAuthService.googleAuthService.signInWithGoogle();
                  User? user=AuthServies.authServies.getCurrentuser();
                  if(user!=null)
                  {
                    Get.off(HomePage());
                  }
                },
                child: Container(
                  height: height*0.045,
                  width: height*0.045,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,blurRadius: 1,spreadRadius: 3,
                      ),
                    ],
                    image: DecorationImage(image: AssetImage('assets/images/splashScreen/google.png')),
                  ),
                ),
              ),
              SignInButton(Buttons.appleDark,mini: true, onPressed: (){}),
            ],
          ),
          SizedBox(height: 30,),
        ],),
      ),
    );
  }
}

//assets/images/splashScreen/bg.jpg
// keytool -list -v  -alias androiddebugkey -keystore C:\Users\SADHANA\.android\debug.keystore
