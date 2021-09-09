import 'package:flutter/cupertino.dart';
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
      bottomNavigationBar: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: CustomButton(
              color: logic.transferAlert.isTrue ? pPrimaryColor : pBottomNav,
              isEnabled: true,
              tvSize: 16.0,
              tvColor: Colors.white,
              height: 50.0,
              radius: 12.0,
              btnTitle: "Transfer",
              onPress: () {
                if (logic.transferAlert.isTrue) {
                  showCommonWithWidget(
                      imageTrue: true,
                      image: success_tick,
                      context: context,
                      widget: Column(
                        children: [
                          TView(
                            title: "Transfer TDF 3990 was successful",
                            color: Colors.black,
                            size: 22,
                            weight: FontWeight.bold,
                          ),
                          pVerticalSpace(height: 20.0),
                          TView(
                            title: "24 Sept, 2020 At 10:00 PM",
                            color: pTextColor,
                            size: 14,
                            weight: FontWeight.normal,
                          ),
                          pVerticalSpace(height: 25.0),
                          TView(
                            title: "Cashback transferred to account",
                            color: pTextColor,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          pVerticalSpace(height: 25.0),
                          TView(
                            title:
                                "Your cashback will be paid into the bank account provided within 7 working days",
                            color: pTextColor,
                            size: 14,
                            weight: FontWeight.normal,
                          ),
                          pVerticalSpace(height: 35.0),
                          CustomButton(
                            color: pPrimaryColor,
                            tvColor: Colors.white,
                            isEnabled: true,
                            tvSize: 16.0,
                            radius: 12.0,
                            width: 120.0,
                            height: 45.0,
                            btnTitle: 'OK',
                            onPress: () {
                              Get.back();
                              Get.back();
                            },
                          ),
                          pVerticalSpace(height: 15.0),

                        ],
                      ),
                      title: '',
                      message: '');
                }
              }),
        );
      }),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              Obx(() {
                return Visibility(
                  visible: logic.dummy.length >= 2
                      ? logic.showList.isTrue
                      : logic.showList.isFalse,
                  replacement: SizedBox(
                    height: Get.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: logic.dummy.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return listOfBankPaymentsOptions(index);
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget listOfBankPaymentsOptions(int index) {
    return Obx(() {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: logic.isSelectedRadio.value == index
                        ? pPrimaryColor
                        : pDisableColor,
                    width: 1),
                borderRadius: BorderRadius.circular(10.0)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(
                      "https://i.etsystatic.com/23304690/r/il/77fca0/2328867732/il_fullxfull.2328867732_tunp.jpg"),
                ),
              ),
              title: TView(
                title: 'Swedbank Bank ABP',
                size: 12,
                weight: FontWeight.normal,
                color: pTextColor,
                align: TextAlign.start,
              ),
              subtitle: TView(
                title: 'Custome .....2657',
                size: 10,
                color: pTextColor3,
                align: TextAlign.start,
              ),
              trailing: Transform.scale(
                scale: 1.5,
                child: Radio(
                    fillColor: logic.isSelectedRadio.value == index
                        ? MaterialStateProperty.all(pPrimaryColor)
                        : MaterialStateProperty.all(pDisableColor),
                    value: index,
                    groupValue: logic.isSelectedRadio.value,
                    onChanged: (val) {
                      logic.onChange(val);
                    }),
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          )
        ],
      );
    });
  }
}
