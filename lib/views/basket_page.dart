import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/controllers/basket_controller.dart';
import '../controllers/item_controller.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final ItemController itemController = Get.put(ItemController());
  final BasketController basketController = Get.put(BasketController());
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("basket_page.dart - build");
    }
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: _buildBasket());
  }

  Widget _buildBasket() {
    return Material(child: Builder(
      builder: (BuildContext _context) {
        return Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              basketController.basketList(),
              ElevatedButton(onPressed: () {
                basketController.purchaseBasket();
              }, child: const Text("CheckOut"))
            ],
          ),
        );
      },
    ));
  }
}
