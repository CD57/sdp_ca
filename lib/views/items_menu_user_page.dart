import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/top_bar_widget.dart';

class UserItemMenuPage extends StatefulWidget {
  const UserItemMenuPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return UserItemMenuState();
  }
}

class UserItemMenuState extends State<UserItemMenuPage> {
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
            const TopBar('Search and Browse Items'),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _searchItemButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _viewCatagoriesButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchItemButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "Search for an Item",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {});
    });
  }

  Widget _viewCatagoriesButton() {
    return Builder(builder: (context) {
      return CustomButton(
          name: "View Catagories",
          height: _deviceHeight * 0.065,
          width: _deviceWidth * 0.8,
          onPressed: () {});
    });
  }
}
