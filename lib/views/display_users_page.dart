import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/models/user_model.dart';
import '../controllers/user_controller.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/user_list_widget.dart';

late List<UserListWidget> usersListWidget = [];

class DisplayUsersPage extends StatefulWidget {
  const DisplayUsersPage({Key? key}) : super(key: key);
  @override
  State<DisplayUsersPage> createState() => _DisplayUsersPageState();
}

class _DisplayUsersPageState extends State<DisplayUsersPage> {
  final UserController userController = Get.put(UserController());
  late double _deviceHeight;
  late double _deviceWidth;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("display_users_page.dart - build");
    }
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: _buildItemList());
  }

  Widget _buildItemList() {
    return Material(child: Builder(
      builder: (BuildContext _context) {
        return Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopBar(
                'Users',
                primaryAction: IconButton(
                  icon: const Icon(
                    Icons.keyboard_return_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                secondaryAction: IconButton(
                  icon: const Icon(
                    Icons.refresh_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
              _userList(context),
            ],
          ),
        );
      },
    ));
  }

  _userList(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: userController.usersRef.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data == null) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          List<UserListWidget> usersList = [];

          for (var doc in (snapshot.data!).docs) {
            UserModel aUser = UserModel.fromDocument(doc);
            if (kDebugMode) {
              print("User: " + aUser.toString());
            }
            UserListWidget userForList = UserListWidget(aUser);
            usersList.add(userForList);
          }

          if (usersList.isEmpty) {
            return const Center(
              child: Text(
                "No Users Found",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 45.0,
                ),
              ),
            );
          } else {
            return Flexible(
              child: ListView(
                children: usersList,
              ),
            );
          }
        }

        return Center(
          child: ListView(
            shrinkWrap: true,
            children: const <Widget>[
              Text(
                "Loading...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
