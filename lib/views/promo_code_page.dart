import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp_ca/controllers/promo_controller.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/top_bar_widget.dart';
import '../widgets/user_input_widget.dart';

class PromoCodePage extends StatefulWidget {
  const PromoCodePage({Key? key}) : super(key: key);
  @override
  State<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  final PromoController _promoController = Get.put(PromoController());
  final _inputFormKey = GlobalKey<FormState>();
  late double _deviceHeight;
  late double _deviceWidth;
  late String _promoCode;
  late String _promoDiscount;


  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("promo_code_page.dart - build()");
    }
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopBar(
              'Create a Promo Code',
              primaryAction: IconButton(
                icon: const Icon(Icons.keyboard_return_rounded,
                    color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            _promoCodeForm(),
            SizedBox(
              height: _deviceHeight * 0.1,
            ),
            _customButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoCodeForm() {
    return SizedBox(
      height: _deviceHeight * 0.50,
      child: Form(
        key: _inputFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UserInputForm(
                initValue: "",
                onSaved: (_value) {
                  setState(() {
                    _promoCode = _value;
                  });
                },
                regex: r'.{6,}',
                hint: "Promo Code",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
            UserInputForm(
                initValue: "",
                onSaved: (_value) {
                  setState(() {
                    _promoDiscount = _value;
                  });
                },
                regex: r'.{1,}',
                hint: "Amount Off (in euro)",
                hidden: false),
            SizedBox(
              height: _deviceHeight * 0.01,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton() {
    return CustomButton(
        name: "Add Promotional Code",
        height: _deviceHeight * 0.065,
        width: _deviceWidth * 0.65,
        onPressed: () {
          if (_inputFormKey.currentState!.validate()) {
            _inputFormKey.currentState!.save();
            _promoController.createPromo(
                _promoCode, _promoDiscount);
            Get.back();
          } else {
            if (kDebugMode) {
              print(
                  "promo_code_page.dart - _customButton - _inputFormKey invalid");
            }
          }
        });
  }
}
