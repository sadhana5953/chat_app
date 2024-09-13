import 'package:chat_app/Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFireStoreService
{
  CloudFireStoreService._();
  static CloudFireStoreService cloudFireStoreService=CloudFireStoreService._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> insertUserIntoFireStore(UserModel user)
  async {
    await firestore.collection("users").doc(user.email).set({
      'email':user.email,
      'name':user.name,
      'phone':user.phone,
      'token':user.token,
      'image':user.image,
    });
  }
}