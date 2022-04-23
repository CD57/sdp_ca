import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/models/item_model.dart';
import 'package:sdp_ca/widgets/item_list_widget.dart';
import '../controllers/item_controller.dart';
import '../widgets/top_bar_widget.dart';

class DisplayItemsPage extends StatefulWidget {
  const DisplayItemsPage({Key? key}) : super(key: key);
  @override
  State<DisplayItemsPage> createState() => _DisplayItemsPageState();
}

class _DisplayItemsPageState extends State<DisplayItemsPage> {
  final ItemController itemController = Get.put(ItemController());
  late String sortByString = "n";
  late double _deviceHeight;
  late double _deviceWidth;
  bool isLoading = true;
  bool sortByTitle = true;
  bool sortByPrice = false;
  bool sortByCategory = false;
  bool sortByManufacturer = false;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("display_items_page.dart - build");
    }
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: _buildItemList());
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
              TopBar(
                'Items',
                primaryAction: IconButton(
                  icon: const Icon(
                    Icons.keyboard_return_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                secondaryAction: IconButton(
                  icon: const Icon(
                    Icons.refresh_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ),
              _sortByBar(context),
              SizedBox(
                height: _deviceHeight * 0.02,
              ),
              _itemList(context),
            ],
          ),
        );
      },
    ));
  }

  _itemList(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: itemController.itemsRef.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<ItemListWidget> itemsList = [];

          for (var doc in (snapshot.data!).docs) {
            ItemModel anItem = ItemModel.fromDocument(doc);
            if (kDebugMode) {
              print("Item: " + anItem.toString());
            }
            ItemListWidget itemForList = ItemListWidget(anItem);
            itemsList.add(itemForList);
          }

          if (itemsList.isEmpty) {
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
          } else {
            return Flexible(child: ListView(children: sortList(itemsList)));
          }
        }
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

  _sortByBar(BuildContext context) {
    MaterialColor isSelected = Colors.blue;
    MaterialColor notSelected = Colors.grey;
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ElevatedButton(
          child: const Text('Title'),
          style: ElevatedButton.styleFrom(
              primary: sortByString.contains("t") ? isSelected : notSelected),
          onPressed: () {
            setState(() {
              sortByString = "t";
              sortByTitle = !sortByTitle;
            });
          },
        ),
        ElevatedButton(
          child: const Text('Price'),
          style: ElevatedButton.styleFrom(
              primary: sortByString.contains("p") ? isSelected : notSelected),
          onPressed: () {
            setState(() {
              sortByString = "p";
              sortByPrice = !sortByPrice;
            });
          },
        ),
        ElevatedButton(
          child: const Text('Manufacturer'),
          style: ElevatedButton.styleFrom(
              primary: sortByString.contains("m") ? isSelected : notSelected),
          onPressed: () {
            setState(() {
              sortByString = "m";
              sortByManufacturer = !sortByManufacturer;
            });
          },
        ),
        ElevatedButton(
          child: const Text('Category'),
          style: ElevatedButton.styleFrom(
              primary: sortByString.contains("c") ? isSelected : notSelected),
          onPressed: () {
            setState(() {
              sortByString = "c";
              sortByCategory = !sortByCategory;
            });
          },
        ),
      ],
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
          if (kDebugMode) {
            print("display_items_page.dart - sortList - Invalid choice");
          }
          return itemsList;
        }
    }
  }
}
