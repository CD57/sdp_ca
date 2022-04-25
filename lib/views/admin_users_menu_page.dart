import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/views/create_item_page.dart';
import 'package:sdp_ca/views/display_items_page.dart';
import 'package:sdp_ca/views/display_users_page.dart';
import 'package:sdp_ca/views/promo_code_page.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/top_bar_widget.dart';

class AdminUserMenuPage extends StatefulWidget {
  const AdminUserMenuPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminUsersMenuState();
  }
}

class AdminUsersMenuState extends State<AdminUserMenuPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("admin_items_menu_page.dart - build()");
    }
    return _buildUI();
  }

  Widget _buildUI() {
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
          children: [
            const TopBar('Admin Menu - User Options'),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _viewUsersButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _promoCodesButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _viewUsersButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "View Users",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {
            Get.to(() => const DisplayUsersPage());
          });
    });
  }

  Widget _promoCodesButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "Promo Codes",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {
            Get.to(() => const PromoCodePage());
          });
    });
  }
}
