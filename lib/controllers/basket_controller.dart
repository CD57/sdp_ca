import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/controllers/item_controller.dart';
import 'package:sdp_ca/controllers/user_controller.dart';
import 'package:sdp_ca/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/item_list_widget.dart';
import 'promo_controller.dart';

class BasketController extends GetxController {
  final CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> receiptsRef =
      FirebaseFirestore.instance.collection('receipts');
  final CollectionReference<Map<String, dynamic>> reviewsRef =
      FirebaseFirestore.instance.collection('reviews');

  final UserController userController = Get.put(UserController());
  final ItemController itemController = Get.put(ItemController());
  final PromoController promoController = Get.put(PromoController());
  late List<ItemListWidget> basketListWidget = [];
  late List<ItemModel> itemBasket = [];
  late List<String> receiptsList = [];
  late String promotionID = "";
  late double totalPrice = 0.0;
  late int itemAmount = 0;
  late bool promoApplied = false;

  purchaseBasket() async {
    for (var item in itemBasket) {
      item.stockLevel = (int.parse((item.stockLevel)) - 1).toString();
      itemController.updateStock(item);
      if (kDebugMode) {
        print("Item Bought: " + item.title);
      }
    }
    if (kDebugMode) {
      print("Total Purchase: $totalPrice for $itemAmount items...");
    }
    await createRecepit(itemBasket);
    promoApplied = false;
    totalPrice = 0.0;
    itemAmount = 0;
    itemBasket = [];
  }

  applyPromoCode(String code) async {
    if (promoApplied) {
      if (kDebugMode) {
        print("applyPromoCode - Already Applied");
      }
      return "Already Promo Code Applied";
    }
    String promoOffer = await promoController.checkPromo(code);
    double tempTotal = totalPrice;
    if (promoOffer == "Invalid") {
      if (kDebugMode) {
        print("applyPromoCode - Invalid");
      }
      return "Invalid Promo Code";
    } else {
      if (kDebugMode) {
        print("applyPromoCode - Valid");
      }
      totalPrice = totalPrice - double.parse(promoOffer);
      if (kDebugMode) {
        print(
            "$promoOffer discounted, old total $tempTotal, new total $totalPrice");
      }
      return "$promoOffer discounted, old total $tempTotal, new total $totalPrice";
    }
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

  createRecepit(List<ItemModel> itemBasket) async {
    String timeReference = DateTime.now().toString();
    DocumentSnapshot docSnapShot = await usersRef
        .doc(userController.currentUser!.email!)
        .collection("receipts")
        .doc(timeReference)
        .get();
    if (!docSnapShot.exists) {
      for (var x in itemBasket) {
        receiptsList.add(x.title);
      }
      await usersRef
          .doc(userController.currentUser!.email!)
          .collection("receipts")
          .doc(timeReference)
          .set({
        "itemsBought": receiptsList,
        "totalPrice": totalPrice,
        "timeOfPurchase": timeReference,
      });
      docSnapShot = await usersRef
          .doc(userController.currentUser!.email!)
          .collection("receipts")
          .doc(timeReference)
          .get();
      if (kDebugMode) {
        print("promo_controller.dart - New Recepit Added: " + timeReference);
      }
    } else {
      if (kDebugMode) {
        print("promo_controller.dart - Promo with same code already exists: " +
            timeReference);
      }
    }
  }

  createReview(String review) async {
    String timeReference = DateTime.now().toString();
    String email = userController.currentUser!.email!;

    DocumentSnapshot docSnapShot = await reviewsRef.doc(timeReference).get();
    if (!docSnapShot.exists) {
      reviewsRef.doc(timeReference).set({
        "user": email,
        "review": review,
      });
      if (kDebugMode) {
        print("promo_controller.dart - New Review Added: " + timeReference);
      }
    } else {
      if (kDebugMode) {
        print(
            "promo_controller.dart - Review already exists: " + timeReference);
      }
    }
  }
}
