import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp_ca/models/promotion_model.dart';

import 'basket_controller.dart';

class PromoController extends GetxController {
  late bool promoApplied = false;
  late String promotionID = "";

  final CollectionReference<Map<String, dynamic>> promoRef =
      FirebaseFirestore.instance.collection('promos');

  createPromo(String code, String discount) async {
    if (kDebugMode) {
      print("promo_controller.dart - createPromo()");
    }
    DocumentSnapshot docSnapShot = await promoRef.doc(code).get();
    if (!docSnapShot.exists) {
      await promoRef.doc(code).set({
        "promoCode": code,
        "promoDiscount": discount,
      });
      docSnapShot = await promoRef.doc(code).get();
      if (kDebugMode) {
        print("promo_controller.dart - New Promo Code Added: " + code);
      }
    } else {
      if (kDebugMode) {
        print("promo_controller.dart - Promo with same code already exists: " +
            code);
      }
    }
  }

  Future<String> checkPromo(String code) async {
    if (kDebugMode) {
      print("promo_controller.dart - checkPromo()");
    }
    DocumentSnapshot docSnapShot;
    docSnapShot = await promoRef.doc(code).get();
    if (kDebugMode) {
      print(docSnapShot.id);
    }
    if (docSnapShot.exists) {
      PromotionModel promo = PromotionModel.fromDocument(docSnapShot);
      if (kDebugMode) {
        print("promo_controller.dart - Promo Code Valid: " + promo.promoCode);
      }
      final BasketController basketController = Get.put(BasketController());
      basketController.promoApplied = true;
      return promo.promoDiscount;
    } else {
      if (kDebugMode) {
        print("promo_controller.dart - Promo Code Not Found: " + code);
      }
      return "Invalid";
    }
  }
}
