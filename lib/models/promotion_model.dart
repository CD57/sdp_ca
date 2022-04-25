import 'package:cloud_firestore/cloud_firestore.dart';

class PromotionModel {
  late String promoCode;
  late String promoDiscount;

  PromotionModel({required this.promoCode, required this.promoDiscount});

  factory PromotionModel.fromDocument(DocumentSnapshot doc) {
    return PromotionModel(
      promoCode: doc['promoCode'],
      promoDiscount: doc['promoDiscount'],
    );
  }

  @override
  String toString() => 'PromotionModel(promoCode: $promoCode, discount: $promoDiscount)';
}
