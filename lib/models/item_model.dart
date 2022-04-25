import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  late String title = "";
  late String manufacturer = "";
  late String price = "";
  late String stockLevel = "";
  late String category = "";

  ItemModel(
      {required this.title,
      required this.manufacturer,
      required this.price,
      required this.stockLevel,
      required this.category});

  factory ItemModel.fromDocument(DocumentSnapshot doc) {
    return ItemModel(
      title: doc['title'],
      manufacturer: doc['manufacturer'],
      price: doc['price'],
      stockLevel: doc['stockLevel'],
      category: doc['category'],
    );
  }

  @override
  String toString() {
    return 'ItemModel(title: $title, manufacturer: $manufacturer, price: $price, stockLevel: $stockLevel, category: $category)';
  }
}
