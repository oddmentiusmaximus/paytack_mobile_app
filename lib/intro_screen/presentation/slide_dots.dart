import 'package:flutter/material.dart';
import 'package:paytack/common_function/constants.dart';

class SlideDots extends StatelessWidget {
  bool isActive;

  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 7 : 8,
      width: isActive ? 12 : 9,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: isActive ? pPrimaryColor : pDisableColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
    );
  }
}
