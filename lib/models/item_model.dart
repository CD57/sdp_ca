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

  factory ItemModel.fromJSON(Map<String, dynamic> _json) {
    return ItemModel(
      title: _json["title"],
      manufacturer: _json["manufacturer"],
      price: _json["price"],
      stockLevel: _json["stockLevel"],
      category: _json["category"],
    );
  }

  @override
  String toString() {
    return 'ItemModel(title: $title, manufacturer: $manufacturer, price: $price, stockLevel: $stockLevel, category: $category)';
  }
}
