import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/models/item_model.dart';
import 'package:sdp_ca/views/display_item_page.dart';

import '../controllers/user_controller.dart';

class ItemListWidget extends StatelessWidget {
  final ItemModel anItem;
  const ItemListWidget(this.anItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("item_list_widget.dart - build()");
    }
    final UserController userController = Get.put(UserController());

    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => userController.isAdmin
                ? adminOptions(context)
                : userOptions(context),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(anItem.title,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(" Manufacturer: " + anItem.manufacturer),
                  Text(" Category: " + anItem.category),
                ],
              ),
              subtitle: Text(
                "£" + anItem.price,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Divider(
            height: 2.0,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }

  void adminOptions(BuildContext context) {
    if (kDebugMode) {
      print("item_list_widget.dart - adminOptions");
    }
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Item Options'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => DisplayItemPage(anItem: anItem));
              },
              child: const Text('View Item'),
            ),
          ],
        );
      },
    );
  }

  void userOptions(BuildContext context) {
    if (kDebugMode) {
      print("item_list_widget.dart - userOptions");
    }
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Item Options'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => DisplayItemPage(anItem: anItem));
              },
              child: const Text('View Item'),
            ),
          ],
        );
      },
    );
  }
}
