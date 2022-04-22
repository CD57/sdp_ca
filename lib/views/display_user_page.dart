import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../widgets/top_bar_widget.dart';

class DisplayUserPage extends StatefulWidget {
  final UserModel aUser;
  const DisplayUserPage({Key? key, required this.aUser}) : super(key: key);
  @override
  _DisplayUserState createState() => _DisplayUserState();
}

class _DisplayUserState extends State<DisplayUserPage> {
  final UserController userController = Get.put(UserController());
  final UserController itemController = Get.put(UserController());
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TopBar(widget.aUser.email, primaryAction: backButton()),
            buildUser(),
          ],
        ),
      ),
    );
  }

  buildUser() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[Text("User Details")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        itemButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              "ID: " + widget.aUser.id,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "Email: " + widget.aUser.email,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  itemButton() {
    if (userController.isAdmin) {
      return buildButton(
          text: "Admin User Options", function: adminUserOptions);
    } else {
      return buildButton(text: "Add to Basket", function: addToBasket);
    }
  }

  backButton() {
    return IconButton(
      icon: const Icon(
        Icons.keyboard_return_rounded,
        color: Colors.white,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }

  buildButton({required String text, required Function()? function}) {
    return TextButton(
      onPressed: function,
      child: Container(
        width: 200.0,
        height: 30.0,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  adminUserOptions() {
    return showDialog(
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
                //Get.to(() => UpdateUserPage(anUser: widget.anUser));
              },
              child: const Text('Edit User'),
            ),
            TextButton(
              onPressed: () async {
                // await itemController.deleteUser(widget.anUser);
                // Get.back();
                // Get.back();
                // Get.back();
              },
              child: const Text('Delete User'),
            ),
          ],
        );
      },
    );
  }

  addToBasket() {
    if (kDebugMode) {
      print("User Profile Message Button Pressed");
    }
  }
}
