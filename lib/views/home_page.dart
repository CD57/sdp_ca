import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/views/admin_users_menu_page.dart';
import 'package:sdp_ca/views/basket_page.dart';
import 'package:sdp_ca/views/display_items_page.dart';
import 'package:sdp_ca/views/profile_page.dart';
import '../controllers/basket_controller.dart';
import '../controllers/index_controller.dart';
import '../controllers/user_controller.dart';
import 'admin_items_menu_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final IndexController indexController = Get.put(IndexController());
  final UserController userController = Get.put(UserController());
  final BasketController basketController = Get.put(BasketController());
  final PageController pageController = PageController();
  late bool isLoading = true;
  late bool isAdmin;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? buildLoadingContent()
          : isAdmin
              ? buildAdminMenu()
              : buildUserMenu(),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: indexController.index.value,
          onTap: onTap,
          activeColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded)),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_basket_rounded)),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded)),
          ]),
    );
  }

  // Displays content while loadingBool is true
  buildLoadingContent() {
    return const Center(child: CircularProgressIndicator());
  }

  // Displays Admin Menu if isAdmin is true
  buildAdminMenu() {
    return PageView(children: const <Widget>[
      AdminItemMenuPage(),
      AdminUserMenuPage(),
      ProfilePage(), // Profile Page
    ], controller: pageController, onPageChanged: onPageChanged);
  }

  // Displays User Menu
  buildUserMenu() {
    return PageView(children: const <Widget>[
      DisplayItemsPage(),
      BasketPage(),
      ProfilePage(), // Profile Page
    ], controller: pageController, onPageChanged: onPageChanged);
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

  // Check details regarding current user
  void checkUser() async {
    await userController.checkUserExists();
    await checkIfAdmin();
  }

  // Check if user is an admin, display admin menu if true
  checkIfAdmin() async {
    bool check = await userController.checkAdmin();
    if (check && userController.userState.state.toString() == "user") {
      userController.userState.touch();
    }
    setState(() {
      isAdmin = check;
      isLoading = false;
      if (kDebugMode) {
        print("IS ADMIN: $isAdmin");
      }
    });
  }
}
