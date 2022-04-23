import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/controllers/item_controller.dart';
import 'package:sdp_ca/models/item_model.dart';

import '../widgets/item_list_widget.dart';

class BasketController extends GetxController {
  final ItemController itemController = Get.put(ItemController());
  late List<ItemListWidget> basketListWidget = [];
  late List<ItemModel> itemBasket = [];
  late String promotionID = "";
  late double totalPrice = 0.0;
  late int itemAmount = 0;

  purchaseBasket() {
    for (var item in itemBasket) {
      item.stockLevel = (int.parse((item.stockLevel))-1).toString();
      itemController.updateStock(item);
      if (kDebugMode) {
        print("Item Bought: " + item.title);
      }
    }
    if (kDebugMode) {
      print("Total Purchase: $totalPrice for $itemAmount items...");
    }
    totalPrice = 0.0;
    itemAmount = 0;
    itemBasket = [];
  }

  addToBasket(ItemModel anItem) {
    itemBasket.add(anItem);
    itemAmount++;
    totalPrice = totalPrice + double.parse(anItem.price);
  }

  removeFromBasket(ItemModel anItem) {
    itemBasket.remove(anItem);
    itemAmount--;
    totalPrice = totalPrice - double.parse(anItem.price);
  }

  basketList() {
    basketListWidget = [];
    for (ItemModel item in itemBasket) {
      ItemListWidget itemForList = ItemListWidget(item);
      basketListWidget.add(itemForList);
    }
    if (basketListWidget.isNotEmpty) {
      return Flexible(child: ListView(children: basketListWidget));
    } else {
      return const Center(
        child: Text(
          "No Items Available",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 45.0,
          ),
        ),
      );
    }
  }
}
