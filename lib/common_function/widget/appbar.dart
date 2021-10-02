import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';

AppBar commonAppBar(String appBarTitle,
    {bool? isTrue,
    double? size = 14,
    String? step,
      Color? textColor = pBottomNav,
    Color? color = Colors.white}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    title: Container(
      child: Row(
        children: [
          InkWell(
              onTap: () {
                Get.back();
              },
              child: isTrue == true
                  ? Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 22,
                    )
                  : Container(
                      child: Image.asset(logo_mark),
                    )),
          TView(
            title: appBarTitle,
            size: size!,
            weight: FontWeight.bold,
            color: textColor!,
          ),
        ],
      ),
    ),
    backgroundColor:color,
  );
}
