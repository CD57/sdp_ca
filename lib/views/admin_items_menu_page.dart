import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/views/create_item_page.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/top_bar_widget.dart';

class AdminItemMenuPage extends StatefulWidget {
  const AdminItemMenuPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AdminItemMenuState();
  }
}

class AdminItemMenuState extends State<AdminItemMenuPage> {
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
            TopBar(
              'Admin Stock Menu',
              primaryAction: IconButton(
                icon: const Icon(Icons.logout_sharp, color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _createItemButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _viewItemButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _editItemButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _deleteItemButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _createItemButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "Create an Item",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {
            Get.to(() => const CreateItemPage());
          });
    });
  }

  Widget _viewItemButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "View an Item",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {});
    });
  }

  Widget _editItemButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "Update an Item",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {});
    });
  }

  Widget _deleteItemButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "Delete an Item",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {});
    });
  }
}
