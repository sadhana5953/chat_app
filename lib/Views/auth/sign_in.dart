import 'package:chat_app/Controller/auth_controller.dart';
import 'package:chat_app/Servies/google_auth_servies.dart';
import 'package:chat_app/Views/auth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../Servies/auth_servies.dart';
import '../HomeScreen/homePage.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

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
        height: height*0.700,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35),),
        ),
        child: Column(mainAxisAlignment:MainAxisAlignment.center,children: [
          Spacer(),
          Text('Welcome back',style: TextStyle(color: Color(0xff3f6edb),fontWeight: FontWeight.bold,fontSize: 35),),
         Spacer(),
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
          TextButton(
              onPressed: () {
                Get.to(SignUp());
              },
              child: RichText(text: TextSpan(children: [
                TextSpan(
                  text: "Don't have account? ",
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' Sign Up',
                  style: TextStyle(color: Color(0xff3f6edb),fontWeight: FontWeight.bold),
                ),
              ]))),
          GestureDetector(
              onTap: () async {
                String resopnse=await AuthServies.authServies.signInAccountWithEmailAndPassword(controller.txtEmail.text, controller.txtPassword.text);
                User? user=AuthServies.authServies.getCurrentuser();
                if(user!=null&&resopnse=='success')
                {
                  Get.off(HomePage());
                }else{
                  Get.snackbar('SignIn Failed!', resopnse,duration: Duration(seconds: 5));
                }
                controller.txtPassword.clear();
                controller.txtEmail.clear();
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
                child: Text('Sign In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
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
              Text('Sign in with',style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold),),
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
