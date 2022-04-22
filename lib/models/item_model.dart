import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  late String title = "";
  late String manufacturer = "";
  late String price = "";
  late String stockLevel = "";

  ItemModel({title, manufacturer, price, stockLevel});

  factory ItemModel.fromDocument(DocumentSnapshot doc) {
    return ItemModel(
        title: doc['title'],
        manufacturer: doc['manufacturer'],
        price: doc['price'],
        stockLevel: doc['stockLevel']);
  }

  @override
  String toString() {
    return 'ItemModel(title: $title, manufacturer: $manufacturer, price: $price, stockLevel: $stockLevel)';
  }
}
