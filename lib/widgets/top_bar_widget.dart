import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String _barTitle;
  final Widget? primaryAction;
  final Widget? secondaryAction;

  const TopBar(
    this._barTitle, {
    Key? key,
    this.primaryAction,
    this.secondaryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildUI(context);
  }

  Widget _buildUI(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: _deviceHeight * 0.10,
      width: _deviceWidth,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (secondaryAction != null) secondaryAction!,
          _titleBar(),
          if (primaryAction != null) primaryAction!,
        ],
      ),
    );
  }

  Widget _titleBar() {
    return Text(
      _barTitle,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
