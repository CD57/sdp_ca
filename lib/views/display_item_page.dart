import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/views/update_item_page.dart';
import '../controllers/basket_controller.dart';
import '../controllers/item_controller.dart';
import '../controllers/user_controller.dart';
import '../models/item_model.dart';
import '../widgets/top_bar_widget.dart';

class DisplayItemPage extends StatefulWidget {
  final ItemModel anItem;
  const DisplayItemPage({Key? key, required this.anItem}) : super(key: key);
  @override
  _DisplayItemState createState() => _DisplayItemState();
}

class _DisplayItemState extends State<DisplayItemPage> {
  final UserController userController = Get.put(UserController());
  final ItemController itemController = Get.put(ItemController());
  final BasketController basketController = Get.put(BasketController());
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            TopBar(widget.anItem.title, primaryAction: backButton()),
            buildItem(),
          ],
        ),
      ),
    );
  }

  buildItem() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const <Widget>[Text("Item Details")],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        itemButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              "Title: " + widget.anItem.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              "Manufacturer: " + widget.anItem.manufacturer,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(top: 2.0),
            child: Text("Price: " + widget.anItem.price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }

  itemButton() {
    if (userController.isAdmin) {
      return buildButton(
          text: "Admin Item Options", function: adminItemOptions);
    } else {
      return buildButton(text: "Add to Basket", function: addToBasket);
    }
  }

  backButton() {
    return IconButton(
      icon: const Icon(
        Icons.keyboard_return_rounded,
        color: Colors.white,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }

  buildButton({required String text, required Function()? function}) {
    return TextButton(
      onPressed: function,
      child: Container(
        width: 200.0,
        height: 30.0,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  adminItemOptions() {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Item Options'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => UpdateItemPage(anItem: widget.anItem));
              },
              child: const Text('Edit Item'),
            ),
            TextButton(
              onPressed: () async {
                await itemController.deleteItem(widget.anItem);
                Get.back();
                Get.back();
                Get.back();
              },
              child: const Text('Delete Item'),
            ),
          ],
        );
      },
    );
  }

  addToBasket() {
    basketController.addToBasket(widget.anItem);
  }
}
