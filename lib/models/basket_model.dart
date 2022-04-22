import 'package:cloud_firestore/cloud_firestore.dart';

class BasketModel {
  final String uid;
  final int itemAmount;
  final int totalPrice;
  final String promotionID;
  final List<String> itemIDs;

  BasketModel(
      {required this.uid,
      required this.itemAmount,
      required this.totalPrice,
      required this.promotionID,
      required this.itemIDs});

  factory BasketModel.fromDocument(DocumentSnapshot doc) {
    return BasketModel(
        uid: doc['uid'],
        itemAmount: doc['itemAmount'],
        totalPrice: doc['totalPrice'],
        promotionID: doc['promotionID'],
        itemIDs: doc['itemIDs']);
  }

  @override
  String toString() {
    return 'BasketModel(uid: $uid, itemAmount: $itemAmount, totalPrice: $totalPrice, promotionID: $promotionID, itemIDs: $itemIDs)';
  }
}
