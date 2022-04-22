import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  late String promoID = "";
  late String discount = "";

  PromotionModel({promoID, discount});

  factory PromotionModel.fromDocument(DocumentSnapshot doc) {
    return PromotionModel(
      promoID: doc['tipromoIDtle'],
      discount: doc['discount'],
    );
  }

  @override
  String toString() => 'PromotionModel(promoID: $promoID, discount: $discount)';
}
