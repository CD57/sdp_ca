import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  final CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('users');
  final currentUser = FirebaseAuth.instance.currentUser;

  // Checks if user exists, creates user if not found
  checkUserExists() async {
    if (kDebugMode) {
      print("user_controller.dart - checkUserExists()");
    }
    DocumentSnapshot docSnapShot = await usersRef.doc(currentUser?.email).get();
    DateTime timestamp = DateTime.now();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("checkUserExists() - User not found, creating new user...");
      }
      await usersRef.doc(currentUser?.email).set({
        "id": currentUser?.uid,
        "email": currentUser?.email,
        "displayName": currentUser?.displayName,
        "photoURL": currentUser?.photoURL,
        "timeCreated": timestamp
      });
      docSnapShot = await usersRef.doc(currentUser?.uid).get();
      if (kDebugMode) {
        print("user_controller.dart - New User Added: " + currentUser!.email!);
      }
    } else {
      if (kDebugMode) {
        print("user_controller.dart - Welcome Back " + currentUser!.email!);
      }
    }
  }
}
