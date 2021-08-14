import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/routes/app_screens.dart';

void actionPopup({
  BuildContext? context,
  Widget? icon,
  String? message,
  TextStyle? msgStyle,
  String? rightButtonText,
  String? leftButtonText,
  VoidCallback? leftBtnCallBack,
  VoidCallback? rightBtnCallBack,
}) {
  showDialog(
    context: context!,
    builder: (cnTx) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
        insetPadding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            pVerticalSpace(height: 28.0),
            Container(child: icon),
            pVerticalSpace(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                message!,
                textAlign: TextAlign.center,
                style: msgStyle ?? commonTextStyle(),
              ),
            ),
            pVerticalSpace(height: 44.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: CustomButton(
                    isEnabled: true,
                    radius: 12.0,
                    tvSize: 15,
                    tvColor: Colors.white,
                    btnTitle: leftButtonText!,
                    onPress: leftBtnCallBack!,
                  )),
                  pHorizontalSpace(width: 8.0),
                  Expanded(
                      child: CustomButton(
                          isEnabled: true,
                          tvColor: Colors.white,
                          radius: 12.0,
                          tvSize: 15,
                          btnTitle: rightButtonText!,
                          onPress: rightBtnCallBack!))
                ],
              ),
            ),
            pVerticalSpace(height: 28.0),
          ],
        ),
      ),
    ),
  );
}

Future<void> showCommonWithWidget({
  BuildContext? context,
  Widget? widget,
  String? image,
  bool imageTrue = false,
  String? title,
  String? message,
  bool barrierDismissible = false,
}) async {
  showDialog(
    context: context!,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
        insetPadding:
            const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: const Color(0xFFFFFF),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(32.0)),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(
                                    Icons.close,
                                    color: pBottomNav,
                                  )),
                            ),
                          ),
                          imageTrue ? Image.asset(image!) : Container(),
                          TView(
                            title: title!,
                            color: pTextColors,
                            weight: FontWeight.bold,
                            size: 20.0,
                          ),
                          pVerticalSpace(height: 5.0),
                          TView(
                            title: message!,
                            color: pTextColors,
                            size: 14.0,
                          ),
                          pVerticalSpace(height: 14.0),
                          widget!
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
