import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/models/user_details_model.dart';
import 'package:sdp_ca/models/user_model.dart';

import '../controllers/user_controller.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/user_input_widget.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final UserController userController = Get.put(UserController());
  final _inputFormKey = GlobalKey<FormState>();

  late UserDetails _aUser;
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("create_user_page.dart - build()");
    }
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _userDetailsForm(),
            SizedBox(
              height: _deviceHeight * 0.1,
            ),
            _customButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _userDetailsForm() {
    return SizedBox(
      height: _deviceHeight * 0.50,
      child: Form(
        key: _inputFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserInputForm(
                onSaved: (_value) {
                  setState(() {
                    _aUser.name = _value;
                  });
                },
                regex: r'.{3,}',
                hint: "Full Name",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                onSaved: (_value) {
                  setState(() {
                    _aUser.shippingAddress = _value;
                  });
                },
                regex: r'.{3,}',
                hint: "Shipping Address",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                onSaved: (_value) {
                  setState(() {
                    _aUser.paymentMethod = _value;
                  });
                },
                regex: r'.{3,}',
                hint: "Payment Method",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                onSaved: (_value) {
                  setState(() {
                    _aUser.phoneNumber = _value;
                  });
                },
                regex: r".{8,}",
                hint: "Phone Number",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton() {
    return CustomButton(
        name: "Set Details",
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.65,
        onPressed: () async {
          if (_inputFormKey.currentState!.validate()) {
            _inputFormKey.currentState!.save();
            userController.createUserDetails(_aUser);
          } else {
            if (kDebugMode) {
              print(
                  "registration_page.dart - _registerButton - onPressed: Error");
            }
          }
        });
  }
}