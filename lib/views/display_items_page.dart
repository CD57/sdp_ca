import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controllers/item_controller.dart';
import '../controllers/item_search_controller.dart';

class DisplayItemsPage extends StatefulWidget {
  const DisplayItemsPage({Key? key}) : super(key: key);
  @override
  State<DisplayItemsPage> createState() => _DisplayItemsPageState();
}

class _DisplayItemsPageState extends State<DisplayItemsPage> {
  final ItemController itemController = Get.put(ItemController());
  final TextEditingController searchController = TextEditingController();
  late ItemSearchController itemSearchController;
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  void initState() {
    super.initState();
    itemSearchController = Get.put(ItemSearchController());
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("display_items_page.dart - build");
    }
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(appBar: _searchBar(), body: _buildItemList());
  }

  Widget _buildItemList() {
    return Material(child: Builder(
      builder: (BuildContext _context) {
        return Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.symmetric(
              horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
          height: _deviceHeight * 0.98,
          width: _deviceWidth * 0.97,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sortByBar(context),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              itemSearchController.itemList(),
            ],
          ),
        );
      },
    ));
  }

  AppBar _searchBar() {
    return AppBar(
        title: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search for Item",
              hintStyle: const TextStyle(color: Colors.white),
              filled: true,
              prefixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  clear();
                },
              ),
            ),
            onFieldSubmitted: getSearchResults));
  }

  getSearchResults(String query) {
    setState(() {
      Query<Map<String, dynamic>> items =
          itemSearchController.itemsRef.where("title", isEqualTo: query);
      itemSearchController.searchResultsFuture = items;
      itemSearchController.isSearching = true;
    });
  }

  _sortByBar(BuildContext context) {
    MaterialColor isSelected = Colors.blue;
    MaterialColor notSelected = Colors.grey;
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
          child: const Text('Title'),
          style: ElevatedButton.styleFrom(
              primary: itemSearchController.sortByString.contains("t")
                  ? isSelected
                  : notSelected),
          onPressed: () {
            setState(() {
              itemSearchController.sortByString = "t";
              itemSearchController.sortByTitle =
                  !itemSearchController.sortByTitle;
            });
          },
        ),
        ElevatedButton(
          child: const Text('Price'),
          style: ElevatedButton.styleFrom(
              primary: itemSearchController.sortByString.contains("p")
                  ? isSelected
                  : notSelected),
          onPressed: () {
            setState(() {
              itemSearchController.sortByString = "p";
              itemSearchController.sortByPrice =
                  !itemSearchController.sortByPrice;
            });
          },
        ),
        ElevatedButton(
          child: const Text('Manufacturer'),
          style: ElevatedButton.styleFrom(
              primary: itemSearchController.sortByString.contains("m")
                  ? isSelected
                  : notSelected),
          onPressed: () {
            setState(() {
              itemSearchController.sortByString = "m";
              itemSearchController.sortByManufacturer =
                  !itemSearchController.sortByManufacturer;
            });
          },
        ),
        ElevatedButton(
          child: const Text('Category'),
          style: ElevatedButton.styleFrom(
              primary: itemSearchController.sortByString.contains("c")
                  ? isSelected
                  : notSelected),
          onPressed: () {
            setState(() {
              itemSearchController.sortByString = "c";
              itemSearchController.sortByCategory =
                  !itemSearchController.sortByCategory;
            });
          },
        ),
      ],
    );
  }

  clear() {
    setState(() {
      searchController.clear();
      itemSearchController.isSearching = false;
    });
  }
}
