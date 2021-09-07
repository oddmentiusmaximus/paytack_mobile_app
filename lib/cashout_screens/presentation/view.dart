import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/routes/app_screens.dart';

import '../application/logic.dart';

class CashoutScreenPage extends StatelessWidget {
  final logic = Get.find<CashoutScreenLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Cashout",
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
            Row(
              children: [
                InkWell(
                  onTap: () {
                    //TODO:Install Popup
                  },
                  child: TView(
                    title: "Enter amount",
                    size: 16.0,
                    weight: FontWeight.bold,
                    align: TextAlign.start,
                    isMaxLines: false,
                    isOverflow: false,
                    color: pTextColor,
                  ),
                ),
                pHorizontalSpace(width: 5.0),
                Icon(
                  Icons.help_outline,
                  size: 20,
                  color: pPrimaryColor,
                )
              ],
            ),
            pVerticalSpace(height: 5.0),
            TInput(
                controller: logic.amtController,
                type: 'B1',
                hintText: "0 Kr",
                maxLines: 1,
                isEdit: false,
                isError: false,
                isInput: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(240),
                ],
                keyboardType: TextInputType.name,
                onChange: (val) {
                  if (val.isEmpty) {
                    logic.amtError.value = true;
                  } else {
                    logic.amtError.value = false;
                  }
                }),
            pVerticalSpace(height: 5.0),
            Obx(() {
              return Visibility(
                  visible: logic.amtError.isTrue,
                  child: TView(
                    title: 'Please enter an Amount',
                    size: 12,
                    color: pError,
                  ));
            }),
            pVerticalSpace(height: 45.0),
            TView(
              title: "Select your account to transfer cashback",
              size: 16.0,
              weight: FontWeight.bold,
              align: TextAlign.start,
              isMaxLines: false,
              isOverflow: false,
              color: pTextColor,
            ),
            pVerticalSpace(height: 25.0),
            Visibility(
              visible: false,
              replacement: SizedBox(
                height: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return listOfBankPaymentsOptions();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.bankDetailsPage);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: pPrimaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TView(
                          title: "Add your payment method",
                          size: 14.0,
                          weight: FontWeight.bold,
                          align: TextAlign.center,
                          isMaxLines: false,
                          isOverflow: false,
                          color: pTextColor,
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.add_circle_outline,
                            color: pPrimaryColor,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Obx(() {
              return CustomButton(
                  color:
                      logic.transferAlert.isTrue ? pPrimaryColor : pBottomNav,
                  isEnabled: true,
                  tvSize: 16.0,
                  tvColor: Colors.white,
                  height: 50.0,
                  radius: 12.0,
                  btnTitle: "Transfer",
                  onPress: () {
                    if (logic.transferAlert.isFalse) {
                      showCommonWithWidget(
                          context: context,
                          widget: CustomButton(
                            color: pPrimaryColor,
                            tvColor: Colors.white,
                            isEnabled: true,
                            tvSize: 16.0,
                            radius: 12.0,
                            btnTitle: 'OK',
                            onPress: () {},
                          ),
                          title: " Transfer TDF 3990 was successful",
                          message:
                              "Your cashback will be paid into the bank account provided within 7 working days");
                    }
                  });
            }),
            pVerticalSpace(height: 25.0),
          ],
        ),
      ),
    );
  }

  Widget listOfBankPaymentsOptions() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: pPrimaryColor, width: 1),
              borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    "https://i.etsystatic.com/23304690/r/il/77fca0/2328867732/il_fullxfull.2328867732_tunp.jpg"),
              ),
            ),
            title: TView(
              title: 'Pizza Hut',
              size: 15,
              weight: FontWeight.bold,
              color: pTextColor,
              align: TextAlign.start,
            ),
            subtitle: TView(
              title: '21 Sept at 20:30',
              size: 12,
              color: pTextColor3,
              align: TextAlign.start,
            ),
            trailing: TView(
              title: '40 kr',
              size: 14,
              color: pTextColor,
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
        )
      ],
    );
  }
}
