import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/user_input_widget.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({Key? key}) : super(key: key);
  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  final ItemController _itemController = Get.put(ItemController());
  final _inputFormKey = GlobalKey<FormState>();
  late double _deviceHeight;
  late double _deviceWidth;
  late String _title;
  late String _manufacturer;
  late String _price;
  late String _stockLevel;
  late String _category;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("create_item_page.dart - build()");
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
            TopBar(
              'Create an Item',
              primaryAction: IconButton(
                icon: const Icon(Icons.keyboard_return_rounded,
                    color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            _itemDetailsForm(),
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

  Widget _itemDetailsForm() {
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
                initValue: "",
                onSaved: (_value) {
                  setState(() {
                    _title = _value;
                  });
                },
                regex: r'.{3,}',
                hint: "Unique Item Title",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: "",
                onSaved: (_value) {
                  setState(() {
                    _manufacturer = _value;
                  });
                },
                regex: r'.{3,}',
                hint: "Manufacturer",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: "",
                onSaved: (_value) {
                  setState(() {
                    _price = _value;
                  });
                },
                regex: r'.{1,}',
                hint: "Price",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: "",
                onSaved: (_value) {
                  setState(() {
                    _stockLevel = _value;
                  });
                },
                regex: r".{1,}",
                hint: "Stock Level",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: "",
                onSaved: (_value) {
                  setState(() {
                    _category = _value;
                  });
                },
                regex: r".{1,}",
                hint: "Category",
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
        name: "Add Item to Stock",
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.65,
        onPressed: () {
          if (_inputFormKey.currentState!.validate()) {
            _inputFormKey.currentState!.save();
            _itemController.createItem(
                _title, _manufacturer, _price, _stockLevel, _category);
            Get.back();
          } else {
            if (kDebugMode) {
              print(
                  "Create_item_page.dart - _registerButton - onPressed: Error");
            }
          }
        });
  }
}
