import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytack/cashout_screens/application/logic.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';

class CashoutBankDetails extends StatelessWidget {
  final logic = Get.find<CashoutScreenLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Add payment method",
          isTrue: true,
          size: 18,
          step: "1",
          color: Colors.transparent,
          textColor: pTextColor),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 2.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pVerticalSpace(height: 25.0),
            TView(
              title: "IBAN*",
              size: 16.0,
              weight: FontWeight.bold,
              align: TextAlign.start,
              isMaxLines: false,
              isOverflow: false,
              color: pTextColor,
            ),
            pVerticalSpace(height: 5.0),
            TInput(
                controller: logic.ibanController,
                type: 'B1',
                hintText: "IBAN",
                maxLines: 1,
                isEdit: false,
                isError: false,
                isInput: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(240),
                ],
                keyboardType: TextInputType.name,
                onChange: (val) {}),
            pVerticalSpace(height: 25.0),
            TView(
              title: "Account Holder*",
              size: 16.0,
              weight: FontWeight.bold,
              align: TextAlign.start,
              isMaxLines: false,
              isOverflow: false,
              color: pTextColor,
            ),
            pVerticalSpace(height: 5.0),
            TInput(
                controller: logic.ibanController,
                type: 'B1',
                hintText: "Account Holder",
                maxLines: 1,
                isEdit: false,
                isError: false,
                isInput: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(240),
                ],
                keyboardType: TextInputType.name,
                onChange: (val) {}),
            pVerticalSpace(height: 45.0),
            TView(
              title: "Important Note:",
              size: 16.0,
              weight: FontWeight.bold,
              align: TextAlign.start,
              isMaxLines: false,
              isOverflow: false,
              color: pTextColor,
            ),
            pVerticalSpace(height: 15.0),
            TView(
              title:
                  "Your cashback will be paid into the bank account provided within 7 working days of your request being approved.",
              size: 13.0,
              weight: FontWeight.normal,
              align: TextAlign.start,
              isMaxLines: false,
              isOverflow: false,
              color: pTextColor,
            ),
            Spacer(),
            CustomButton(
                color: pPrimaryColor,
                isEnabled: true,
                tvSize: 16.0,
                tvColor: Colors.white,
                height: 50.0,
                radius: 12.0,
                btnTitle: "Save details",
                onPress: () {}),
            pVerticalSpace(height: 25.0),
          ],
        ),
      ),
    );
  }
}
