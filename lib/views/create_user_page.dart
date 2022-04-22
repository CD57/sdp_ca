import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  late double _deviceHeight;
  late double _deviceWidth;

  late String _name;
  late String _shippingAddress;
  late String _paymentMethod;
  late String _phoneNumber;
  late bool isAdmin;

  final _inputFormKey = GlobalKey<FormState>();

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
            _registrationForm(),
            SizedBox(
              height: _deviceHeight * 0.1,
            ),
            _registerButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _registrationForm() {
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
                    _name = _value;
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
                    _shippingAddress = _value;
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
                    _paymentMethod = _value;
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
                    _phoneNumber = _value;
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

  Widget _registerButton() {
    return CustomButton(
        name: "Set Details",
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.65,
        onPressed: () async {
          if (_inputFormKey.currentState!.validate()) {
            _inputFormKey.currentState!.save();
            userController.createUserDetails(
                _name, _shippingAddress, _paymentMethod, _phoneNumber, false);
          } else {
            if (kDebugMode) {
              print(
                  "registration_page.dart - _registerButton - onPressed: Error");
            }
          }
        });
  }
}
