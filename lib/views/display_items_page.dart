import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/models/item_model.dart';
import 'package:sdp_ca/widgets/item_list_widget.dart';
import '../controllers/item_controller.dart';
import '../widgets/top_bar_widget.dart';

late List<ItemListWidget> itemsWidgetList = [];

class DisplayItemsPage extends StatefulWidget {
  const DisplayItemsPage({Key? key}) : super(key: key);
  @override
  State<DisplayItemsPage> createState() => _DisplayItemsPageState();
}

class _DisplayItemsPageState extends State<DisplayItemsPage> {
  final ItemController itemController = Get.put(ItemController());
  late double _deviceHeight;
  late double _deviceWidth;
  bool isLoading = true;

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
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && snapshot.data == null) {
          return const Text("Document does not exist");
        }

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
            return Flexible(
              child: ListView(
                children: itemsList,
              ),
            );
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
}
