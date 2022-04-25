import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sdp_ca/views/create_user_page.dart';

import '../models/user_details_model.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('users');
  late User? currentUser = FirebaseAuth.instance.currentUser;
  late bool isAdmin;
  var userState = Stateful(IsUser());

  // Checks if user exists, creates user if not found
  checkUserExists() async {
    currentUser = FirebaseAuth.instance.currentUser;
    if (kDebugMode) {
      print("user_controller.dart - checkUserExists()");
    }
    currentUser = FirebaseAuth.instance.currentUser;
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
  createUserDetails(UserDetails _aUsersDetails) async {
    if (kDebugMode) {
      print("user_controller.dart - createUserDetails()");
    }
    DocumentSnapshot docSnapShot = await usersRef
        .doc(currentUser?.email)
        .collection("UserDetails")
        .doc(_aUsersDetails.phoneNumber)
        .get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print(
            "createUserDetails() - User details not found, creating new user details...");
      }
      await usersRef
          .doc(currentUser?.email)
          .collection("UserDetails")
          .doc(_aUsersDetails.phoneNumber)
          .set({
        "name": _aUsersDetails.name,
        "shippingAddress": _aUsersDetails.shippingAddress,
        "paymentMethod": _aUsersDetails.paymentMethod,
        "phoneNumber": _aUsersDetails.phoneNumber,
      });
      if (kDebugMode) {
        print("user_controller.dart - New User Details Added: " +
            currentUser!.email!);
      }
      currentUser!.updateDisplayName(_aUsersDetails.name);
      Get.back();
    } else {
      if (kDebugMode) {
        print("user_controller.dart - User Details Already Exist");
      }
    }
  }

  // Checks if user details exists, deletes user details if not found
  deleteUser(UserModel _aUser) async {
    if (kDebugMode) {
      print("user_controller.dart - deleteUser()");
    }
    DocumentSnapshot docSnapShot = await usersRef.doc(_aUser.email).get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("deleteUser() - User not found");
      }
      return "Not Found";
    } else {
      if (kDebugMode) {
        print("deleteUser() - Deleting User");
      }
      await usersRef.doc(_aUser.email).delete();
      return "Deleted";
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
      isAdmin = UserModel.fromDocument(docSnapShot).isAdmin;
      return isAdmin;
    }
  }
}

abstract class UserState {
  void handler(Stateful context);
  @override
  String toString();
}

class IsAdmin implements UserState {
  @override
  handler(Stateful context) {
    if (kDebugMode) {
      print("  Handler of StatusOn is being called!");
    }
    context.state = IsUser();
  }

  @override
  String toString() {
    return "admin";
  }
}

class IsUser implements UserState {
  @override
  handler(Stateful context) {
    if (kDebugMode) {
      print("  Handler of StatusOff is being called!");
    }
    context.state = IsAdmin();
  }

  @override
  String toString() {
    return "user";
  }
}

class Stateful {
  UserState _state;

  Stateful(this._state);

  UserState get state => _state;
  set state(UserState newState) => _state = newState;

  void touch() {
    _state.handler(this);
  }
}
