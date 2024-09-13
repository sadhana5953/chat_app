import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Model/user_model.dart';
import 'cloud_firestore_servies.dart';

class GoogleAuthService
{
  GoogleAuthService._();
  static GoogleAuthService googleAuthService = GoogleAuthService._();

  GoogleSignIn googleSignIn=GoogleSignIn();

  Future<void> signInWithGoogle()
  async {
    try
        {
          GoogleSignInAccount? googleSignInAccount=await googleSignIn.signIn();
          GoogleSignInAuthentication authentication= await googleSignInAccount!.authentication;
          AuthCredential credential=GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken,
          );

          UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
          UserModel users = UserModel(
              name: userCredential.user!.displayName,
              email: userCredential.user!.email,
              image: userCredential.user!.photoURL,
              phone: userCredential.user!.phoneNumber,
              token: "------");
          CloudFireStoreService.cloudFireStoreService
              .insertUserIntoFireStore(users);
          log(userCredential.user!.email!);
          log(userCredential.user!.photoURL!);
        }catch(e)
    {
     Get.snackbar("Google sign in failed!",e.toString());
     log(e.toString());
    }
  }

  Future<void> signOutFromGoogle()
  async {
    await googleSignIn.signOut();
  }
}