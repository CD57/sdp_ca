import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp_ca/views/create_user_page.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('users');
  late User? currentUser = FirebaseAuth.instance.currentUser;

  // Checks if user exists, creates user if not found
  checkUserExists() async {
    if (kDebugMode) {
      print("user_controller.dart - checkUserExists()");
    }
    DocumentSnapshot docSnapShot = await usersRef.doc(currentUser?.email).get();
    DateTime timestamp = DateTime.now();
    if (!docSnapShot.exists) {
      await usersRef.doc(currentUser?.email).set({
        "id": currentUser?.uid,
        "email": currentUser?.email,
        "isAdmin": false,
        "timeCreated": timestamp
      });
      docSnapShot = await usersRef.doc(currentUser?.uid).get();
      if (kDebugMode) {
        print("user_controller.dart - New User Added: " + currentUser!.email!);
      }
      Get.to(() => const CreateUserPage());
    } else {
      if (kDebugMode) {
        print("user_controller.dart - Welcome Back " + currentUser!.email!);
      }
    }
  }

  // Checks if user details exists, creates user details if not found
  createUserDetails(String name, String shippingAddress, String paymentMethod,
      String phoneNumber, bool isAdmin) async {
    if (kDebugMode) {
      print("user_controller.dart - createUserDetails()");
    }
    DocumentSnapshot docSnapShot = await usersRef
        .doc(currentUser?.email)
        .collection("UserDetails")
        .doc(currentUser?.uid)
        .get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print(
            "createUserDetails() - User details not found, creating new user details...");
      }
      await usersRef
          .doc(currentUser?.email)
          .collection("UserDetails")
          .doc(currentUser?.uid)
          .set({
        "name": name,
        "shippingAddress": shippingAddress,
        "paymentMethod": paymentMethod,
        "phoneNumber": phoneNumber,
      });
      docSnapShot = await usersRef
          .doc(currentUser?.uid)
          .collection("UserDetails")
          .doc(currentUser?.uid)
          .get();
      if (kDebugMode) {
        print("user_controller.dart - New User Details Added: " +
            currentUser!.email!);
      }
      currentUser!.updateDisplayName(name);
      Get.back();
    } else {
      if (kDebugMode) {
        print("user_controller.dart - User Details Already Exist");
      }
    }
  }

  Future<bool> checkAdmin() async {
    DocumentSnapshot docSnapShot = await usersRef.doc(currentUser?.email).get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("checkAdmin() - User not found...");
      }
      return false;
    } else {
      if (kDebugMode) {
        print("checkAdmin() - User found");
      }
      return UserModel.fromDocument(docSnapShot).isAdmin;
    }
  }
}
