import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp_ca/models/item_model.dart';

class ItemController extends GetxController {
  final CollectionReference<Map<String, dynamic>> itemsRef =
      FirebaseFirestore.instance.collection('items');

  createItem(String title, String manufacturer, String price, String stockLevel,
      String category) async {
    if (kDebugMode) {
      print("item_controller.dart - createItem()");
    }
    DocumentSnapshot docSnapShot = await itemsRef.doc(title).get();
    if (!docSnapShot.exists) {
      await itemsRef.doc(title).set({
        "title": title,
        "manufacturer": manufacturer,
        "price": price,
        "stockLevel": stockLevel,
        "category": category,
      });
      docSnapShot = await itemsRef.doc(title).get();
      if (kDebugMode) {
        print("item_controller.dart - New Item Added: " + title);
      }
    } else {
      if (kDebugMode) {
        print("item_controller.dart - Item with same name already exists: " +
            title);
      }
    }
  }

  getItem(String anItem) async {
    DocumentSnapshot docSnapShot = await itemsRef.doc(anItem).get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("getItem() - Item not found...");
      }
    } else {
      if (kDebugMode) {
        print("getItem() - Item found");
      }
      return ItemModel.fromDocument(docSnapShot);
    }
  }

  updateItem(String itemTitle, ItemModel anItem) async {
    DocumentSnapshot docSnapShot = await itemsRef.doc(itemTitle).get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("updateItem() - Item not found...");
      }
    } else {
      if (kDebugMode) {
        print("updateItem() - Item found: $itemTitle");
      }
      await itemsRef.doc(itemTitle).delete();
      await itemsRef.doc(anItem.title).set({
        "title": anItem.title,
        "manufacturer": anItem.manufacturer,
        "price": anItem.price,
        "stockLevel": anItem.stockLevel,
        "category": anItem.category,
      });
      docSnapShot = await itemsRef.doc(anItem.title).get();
      if (kDebugMode) {
        print("item_controller.dart - Item Updated: " + anItem.title);
      }
      return ItemModel.fromDocument(docSnapShot);
    }
  }

  updateStock(ItemModel anItem) async {
    DocumentSnapshot docSnapShot = await itemsRef.doc(anItem.title).get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("updateStock() - Item not found...");
      }
    } else {
      if (kDebugMode) {
        print("updateStock() - Item found: " + anItem.title);
      }
      await itemsRef.doc(anItem.title).set({
        "title": anItem.title,
        "manufacturer": anItem.manufacturer,
        "price": anItem.price,
        "stockLevel": anItem.stockLevel,
        "category": anItem.category,
      });

      docSnapShot = await itemsRef.doc(anItem.title).get();
      if (kDebugMode) {
        print("item_controller.dart - Item Stock Updated: " + ItemModel.fromDocument(docSnapShot).stockLevel);
      }
      return ItemModel.fromDocument(docSnapShot);
    }
  }

  deleteItem(ItemModel anItem) async {
    DocumentSnapshot docSnapShot = await itemsRef.doc(anItem.title).get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("deleteItem() - Item not found...");
      }
    } else {
      await itemsRef.doc(anItem.title).delete();
      if (kDebugMode) {
        print("deleteItem() - Item Deleted");
      }
      return ItemModel.fromDocument(docSnapShot);
    }
  }
}
