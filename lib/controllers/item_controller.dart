import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp_ca/models/item_model.dart';

class ItemController extends GetxController {
  final CollectionReference<Map<String, dynamic>> itemsRef =
      FirebaseFirestore.instance.collection('items');

  createItem(ItemModel anItem) async {
    if (kDebugMode) {
      print("item_controller.dart - createItem()");
    }
    DocumentSnapshot docSnapShot = await itemsRef.doc(anItem.title).get();
    if (!docSnapShot.exists) {
      await itemsRef.doc(anItem.title).set({
        "title": anItem.title,
        "manufacturer": anItem.manufacturer,
        "price": anItem.price,
        "stockLevel": anItem.stockLevel,
      });
      docSnapShot = await itemsRef.doc(anItem.title).get();
      if (kDebugMode) {
        print("item_controller.dart - New Item Added: " + anItem.title);
      }
    } else {
      if (kDebugMode) {
        print("item_controller.dart - Item with same name already exists: " +
            anItem.title);
      }
    }
  }

  getItem(ItemModel anItem) async {
    DocumentSnapshot docSnapShot = await itemsRef.doc(anItem.title).get();
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

  updateItem(ItemModel anItem) async {
    DocumentSnapshot docSnapShot = await itemsRef.doc(anItem.title).get();
    if (!docSnapShot.exists) {
      if (kDebugMode) {
        print("updateItem() - Item not found...");
      }
    } else {
      if (kDebugMode) {
        print("updateItem() - Item found");
      }
      await itemsRef.doc(anItem.title).set({
        "title": anItem.title,
        "manufacturer": anItem.manufacturer,
        "price": anItem.price,
        "stockLevel": anItem.stockLevel,
      });
      docSnapShot = await itemsRef.doc(anItem.title).get();
      if (kDebugMode) {
        print("item_controller.dart - Item Updated: " + anItem.title);
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
      if (kDebugMode) {
        print("deleteItem() - Item found");
      }
      await itemsRef.doc(anItem.title).delete();
      return ItemModel.fromDocument(docSnapShot);
    }
  }
}
