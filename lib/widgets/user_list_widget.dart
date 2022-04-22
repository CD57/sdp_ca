import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../views/display_user_page.dart';

class UserListWidget extends StatelessWidget {
  final UserModel aUser;
  const UserListWidget(this.aUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("user_list_widget.dart - build()");
    }
    if (kDebugMode) {
      print("User: " + aUser.toString());
    }
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => adminOptions(context),
            child: ListTile(
              title: Text(
                aUser.email,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                aUser.email,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Divider(
            height: 2.0,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }

  void adminOptions(BuildContext context) {
    if (kDebugMode) {
      print("user_list_widget.dart - contactOptions");
    }
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('User Options'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => DisplayUserPage(aUser: aUser));
              },
              child: const Text('View User'),
            ),
          ],
        );
      },
    );
  }
}
