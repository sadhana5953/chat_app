import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthServies
{
  AuthServies._();
  static AuthServies authServies=AuthServies._();
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;

  Future<String> createAccountWithEmailAndPassword(String email,String password)
  async {
    try
        {
          await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
          return 'success';
        }catch(e){
      return e.toString();
    }
  }

  Future<String> signInAccountWithEmailAndPassword(String email,String password)
  async {
    try
    {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    }catch(e){
      return e.toString();
    }
  }

  Future<void> signOut()
  async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentuser()
  {
   User? user = _firebaseAuth.currentUser;
   if(user!=null)
     {
       log("email : ${user.email}");
     }
   return user;
  }
}