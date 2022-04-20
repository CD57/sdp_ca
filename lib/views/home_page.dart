import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/views/profile_page.dart';
import '../controllers/index_controller.dart';
import '../controllers/user_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final IndexController indexController = Get.put(IndexController());
  final UserController userController = Get.put(UserController());
  final PageController pageController = PageController();

  @override
  void initState() {
    if (kDebugMode) {
      print("home_page.dart - initState()");
    }
    super.initState();
    userController.checkUserExists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const <Widget>[
          Text("FIRST PAGE"),
          Text("SECOND PAGE"),
          ProfilePage(), // Profile Page
        ],
        controller: pageController,
        onPageChanged: onPageChanged, // Updates index for page position
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: indexController.index.value,
          onTap: onTap, // Switches Page based on index of item tapped
          activeColor: Colors.green,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.inventory_rounded)), // Display Stock?
            BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded)), // Search Stock?
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle)), // Profile
          ]),
    );
  }

  // Updates index controller
  onPageChanged(int pageIndex) {
    setState(() {
      indexController.index.value = pageIndex;
    });
  }

  // Switches Page when called by OnTap in Bottom Nav Bar
  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
