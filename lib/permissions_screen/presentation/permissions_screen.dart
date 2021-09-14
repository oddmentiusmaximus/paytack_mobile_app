import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/permissions_screen/application/controller.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:get/get.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(background_image), fit: BoxFit.fill),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: commonAppBar("",
            isTrue: true, size: 14, step: "1", color: Colors.transparent),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder<PermissionsController>(builder: (logic) {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                  child: TView(
                    title: "Permissions",
                    size: 24.0,
                    weight: FontWeight.bold,
                    align: TextAlign.start,
                    isMaxLines: false,
                    isOverflow: false,
                    color: pTextColor,
                  ),
                ),
                pVerticalSpace(height: 35.0),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 2.0,
                      ),
                      child: TView(
                        title: 'Marketing',
                        size: 16,
                        color: pPhoneText,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: pPhoneText,
                      ),
                    ),
                  ],
                ),
                pVerticalSpace(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TView(
                      title: 'Email',
                      size: 14,
                      color: pPhoneText,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2.0,
                  ),
                  child: ListTile(
                    title: TView(
                      size: 12,
                      align: TextAlign.start,
                      color: pBottomNav,
                      title:
                          'I consent to receiving a newsletter (no more than once a week) informing me of new merchants where I can collect rewards.',
                    ),
                    trailing: CupertinoSwitch(
                        activeColor: pPrimaryColor,
                        value: logic.emailPermission,
                        onChanged: (newVal) {
                          logic.togglePermission(true, false, false);
                        }),
                  ),
                ),
                pVerticalSpace(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TView(
                      title: 'Push Notifications',
                      size: 14,
                      color: pPhoneText,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2.0,
                  ),
                  child: ListTile(
                    title: TView(
                        size: 12,
                        align: TextAlign.start,
                        color: pBottomNav,
                        title:
                            'I consent to receiving updates about participating merchants local to me.'),
                    trailing: CupertinoSwitch(
                        activeColor: pPrimaryColor,
                        value: logic.pnPermission,
                        onChanged: (newVal) =>
                            logic.togglePermission(false, true, false)),
                  ),
                ),
                pVerticalSpace(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TView(
                      title: 'SMS Notifications',
                      size: 14,
                      color: pPhoneText,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2.0,
                  ),
                  child: ListTile(
                    title: TView(
                      size: 12,
                      align: TextAlign.start,
                      color: pBottomNav,
                      title:
                          'I consent to receiving occasional SMS messages about merchants where I can collect rewards.',
                    ),
                    trailing: CupertinoSwitch(
                        activeColor: pPrimaryColor,
                        value: logic.smsPermission,
                        onChanged: (newVal) =>
                            logic.togglePermission(false, false, true)),
                  ),
                ),
                pVerticalSpace(height: 25.0),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 2.0,
                      ),
                      child: TView(
                        title: 'Service (Required)',
                        size: 16,
                        color: pPhoneText,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.2,
                        color: pPhoneText,
                      ),
                    ),
                  ],
                ),
                pVerticalSpace(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TView(
                      title: 'Bank Linking',
                      size: 14,
                      color: pPhoneText,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2.0,
                  ),
                  child: ListTile(
                    title: TView(
                      size: 12,
                      align: TextAlign.start,
                      color: pBottomNav,
                      isMaxLines: true,
                      title:
                          'I consent to link and other necessary payment providers to monitor purchase made from my bank so that I can collect rewards through cashback app on my qualifying purchase and for such payment with PayTack',
                    ),
                    trailing: CupertinoSwitch(
                        activeColor: pPrimaryColor,
                        value: true,
                        onChanged: (newVal) =>
                            logic.togglePermission(false, false, false)),
                  ),
                ),
                pVerticalSpace(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TView(
                      title: 'Merchant Updates',
                      size: 14,
                      color: pPhoneText,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2.0,
                  ),
                  child: ListTile(
                    title: TView(
                        size: 12,
                        align: TextAlign.start,
                        color: pBottomNav,
                        title:
                            'I consent to receiving notifications and updates about merchants I engage with from cashback app..'),
                    trailing: CupertinoSwitch(
                        activeColor: pPrimaryColor,
                        value: true,
                        onChanged: (newVal) =>
                            logic.togglePermission(false, false, false)),
                  ),
                ),
                pVerticalSpace(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 2.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TView(
                      title: 'Billing',
                      size: 14,
                      color: pPhoneText,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2.0,
                  ),
                  child: ListTile(
                    title: TView(
                        size: 12,
                        align: TextAlign.start,
                        color: pBottomNav,
                        isMaxLines: true,
                        title:
                            'I consent to cashback app providing merchants I engage with, read only access to my first name, age group, gender and transactions in their store in order to bill them, collect my rewards, and pay me. Your email address and phone number is never shared.'),
                    trailing: CupertinoSwitch(
                        activeColor: pPrimaryColor,
                        value: true,
                        onChanged: (newVal) =>
                            logic.togglePermission(false, false, false)),
                  ),
                ),
                pVerticalSpace(height: 25.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: CustomButton(
                      color: pPrimaryColor,
                      tvColor: Colors.white,
                      isEnabled: true,
                      tvSize: 16.0,
                      height: 50.0,
                      radius: 12.0,
                      btnTitle: logic.isSignUp ? "Save and proceed" : "Update",
                      onPress: () {
                        if (logic.isSignUp)
                          Get.toNamed(AppRoute.setPin);
                        else
                          Get.back();
                      }),
                ),
              ],
            );
          }),
        ),
      )
    ]);
  }
}
