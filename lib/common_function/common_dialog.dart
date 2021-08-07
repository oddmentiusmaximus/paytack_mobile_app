import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/button.dart';
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
                    btnTitle: leftButtonText!,
                    onPress: leftBtnCallBack!,
                  )),
                  pHorizontalSpace(width: 8.0),
                  Expanded(
                      child: CustomButton(
                          isEnabled: true,
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
