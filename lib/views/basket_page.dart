import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/controllers/basket_controller.dart';
import 'package:sdp_ca/widgets/user_input_widget.dart';
import '../controllers/item_controller.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final ItemController itemController = Get.put(ItemController());
  final BasketController basketController = Get.put(BasketController());
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("basket_page.dart - build");
    }
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(body: _buildBasket());
  }

  Widget _buildBasket() {
    late String _promoResult = "Enter A Promo Code";
    late String _review = "No Review";
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
              basketController.basketList(),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        final _inputFormKey = GlobalKey<FormState>();
                        return AlertDialog(
                          title: const Text('Enter Promo Code'),
                          actions: [
                            Form(
                              key: _inputFormKey,
                              child: UserInputForm(
                                  initValue: "",
                                  onSaved: (_value) {
                                    setState(() {
                                      _promoResult = _value;
                                    });
                                  },
                                  regex: r'.{1,}',
                                  hint: "Promo Code",
                                  hidden: false),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (_inputFormKey.currentState!.validate()) {
                                  _inputFormKey.currentState!.save();
                                  await basketController
                                      .applyPromoCode(_promoResult);
                                  Get.back();
                                }
                                setState(() {});
                              },
                              child: const Text('Submit'),
                            ),
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Cancel'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text(_promoResult)),
              SizedBox(
                height: _deviceHeight * 0.01,
              ),
              Text("TOTAL PRICE: " + basketController.totalPrice.toString()),
              SizedBox(
                height: _deviceHeight * 0.01,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await basketController.purchaseBasket();
                    setState(() {});
                    showDialog(
                      context: context,
                      builder: (_) {
                        final _inputFormKey2 = GlobalKey<FormState>();
                        return AlertDialog(
                          title: const Text('Leave a review?'),
                          actions: [
                            Form(
                              key: _inputFormKey2,
                              child: UserInputForm(
                                  initValue: "",
                                  onSaved: (_value) {
                                    setState(() {
                                      _review = _value;
                                    });
                                  },
                                  regex: r'.{1,}',
                                  hint: "Review",
                                  hidden: false),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (_inputFormKey2.currentState!.validate()) {
                                  _inputFormKey2.currentState!.save();
                                  await basketController
                                      .createReview(_review);
                                  Get.back();
                                }
                                setState(() {});
                              },
                              child: const Text('Submit'),
                            ),
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('No Thanks'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text("CheckOut"))
            ],
          ),
        );
      },
    ));
  }
}
