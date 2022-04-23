import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';
import '../models/item_model.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/user_input_widget.dart';

class UpdateItemPage extends StatefulWidget {
  final ItemModel anItem;
  const UpdateItemPage({Key? key, required this.anItem}) : super(key: key);
  @override
  State<UpdateItemPage> createState() => _UpdateItemPageState();
}

class _UpdateItemPageState extends State<UpdateItemPage> {
  final ItemController _itemController = Get.put(ItemController());
  final _inputFormKey = GlobalKey<FormState>();
  late double _deviceHeight;
  late double _deviceWidth;
  late String _title = widget.anItem.title;
  late String _manufacturer = widget.anItem.manufacturer;
  late String _price = widget.anItem.price;
  late String _stockLevel = widget.anItem.stockLevel;
  late String _category = widget.anItem.category;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("update_item_page.dart - build()");
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
              'Update Item: ' + widget.anItem.title,
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
                initValue: widget.anItem.title,
                onSaved: (_value) {
                  setState(() {
                    _title = _value;
                  });
                },
                regex: r'.{3,}',
                hint: "Title: " + widget.anItem.title,
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: widget.anItem.manufacturer,
                onSaved: (_value) {
                  setState(() {
                    _manufacturer = _value;
                  });
                },
                regex: r'.{3,}',
                hint: "Manufacturer: " + widget.anItem.manufacturer,
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: widget.anItem.price,
                onSaved: (_value) {
                  setState(() {
                    _price = _value;
                  });
                },
                regex: r'.{1,}',
                hint: "Price: " + widget.anItem.price,
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: widget.anItem.stockLevel,
                onSaved: (_value) {
                  setState(() {
                    _stockLevel = _value;
                  });
                },
                regex: r".{1,}",
                hint: "Stock Level: " + widget.anItem.stockLevel,
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: widget.anItem.category,
                onSaved: (_value) {
                  setState(() {
                    _category = _value;
                  });
                },
                regex: r".{1,}",
                hint: "Category: " + widget.anItem.category,
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
        name: "Update Item Details",
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.65,
        onPressed: () async {
          if (_inputFormKey.currentState!.validate()) {
            _inputFormKey.currentState!.save();
            ItemModel updateItem = ItemModel(
              title: _title,
              manufacturer: _manufacturer,
              price: _price,
              stockLevel: _stockLevel,
              category: _category,
            );
            await _itemController.updateItem(widget.anItem.title, updateItem);
            Get.back();
            Get.back();
            Get.back();
            Get.back();
          } else {
            if (kDebugMode) {
              print(
                  "update_item_page.dart - _registerButton - onPressed: Error");
            }
          }
        });
  }
}
