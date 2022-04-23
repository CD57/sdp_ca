import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sdp_ca/models/item_model.dart';

import '../widgets/item_list_widget.dart';

class ItemSearchController extends GetxController {
  final CollectionReference<Map<String, dynamic>> itemsRef =
      FirebaseFirestore.instance.collection('items');
  late Query<Map<String, dynamic>> searchResultsFuture;
  late List<ItemListWidget> itemsList = [];
  late String sortByString = "t";
  late bool isLoading = true;
  late bool isSearching = false;
  late bool sortByTitle = true;
  late bool sortByPrice = false;
  late bool sortByCategory = false;
  late bool sortByManufacturer = false;

  // getSearchResults(String query) {
  //   Query<Map<String, dynamic>> items = itemsRef.where("title", isEqualTo: query);
  //   searchResultsFuture = items;
  //   isSearching = true;
  // }

  itemList() {
    itemsList = [];
    return FutureBuilder<QuerySnapshot>(
      future: isSearching ? searchResultsFuture.get() : itemsRef.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Once connection complete
        if (snapshot.connectionState == ConnectionState.done) {
          if (kDebugMode) {
            print("Searching - $isSearching");
          }
          // For each doc, use factory to convert doc to ItemModel and add to itemsList
          for (var doc in (snapshot.data!).docs) {
            ItemModel anItem = ItemModel.fromDocument(doc);
            ItemListWidget itemForList = ItemListWidget(anItem);
            itemsList.add(itemForList);
          }
          // Return list, and if empty, return no conent screen
          if (itemsList.isNotEmpty) {
            return Flexible(child: ListView(children: sortList(itemsList)));
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
        // Until connection complete, return loading screen
        return Center(
          child: ListView(
            shrinkWrap: true,
            children: const <Widget>[
              Text(
                "Loading...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<ItemListWidget> sortList(List<ItemListWidget> itemsList) {
    switch (sortByString) {
      case "t": // Sort By Title
        {
          if (sortByTitle) {
            itemsList.sort((item1, item2) {
              return Comparable.compare(
                  item1.anItem.title, item2.anItem.title); // Normal
            });
            return itemsList;
          } else {
            itemsList.sort((item1, item2) {
              return Comparable.compare(
                  item2.anItem.title, item1.anItem.title); // Reversed
            });
            return itemsList;
          }
        }
      case "p": // Sort By Price
        {
          if (sortByPrice) {
            itemsList.sort((item1, item2) {
              return Comparable.compare(
                  item1.anItem.price, item2.anItem.price); // Normal
            });
            return itemsList;
          } else {
            itemsList.sort((item1, item2) {
              return Comparable.compare(
                  item2.anItem.price, item1.anItem.price); // Reversed
            });
            return itemsList;
          }
        }
      case "m": // Sort By Manufacturer
        {
          if (sortByManufacturer) {
            itemsList.sort((item1, item2) {
              return Comparable.compare(item1.anItem.manufacturer,
                  item2.anItem.manufacturer); // Normal
            });
            return itemsList;
          } else {
            itemsList.sort((item1, item2) {
              return Comparable.compare(item2.anItem.manufacturer,
                  item1.anItem.manufacturer); // Reversed
            });
            return itemsList;
          }
        }
      case "c": // Sort By category
        {
          if (sortByCategory) {
            itemsList.sort((item1, item2) {
              return Comparable.compare(
                  item1.anItem.category, item2.anItem.category); // Normal
            });
            return itemsList;
          } else {
            itemsList.sort((item1, item2) {
              return Comparable.compare(
                  item2.anItem.category, item1.anItem.category); // Reversed
            });
            return itemsList;
          }
        }
      default:
        {
          return itemsList;
        }
    }
  }
}
