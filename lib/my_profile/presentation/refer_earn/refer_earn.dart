import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/my_profile/application/profile_controller.dart';
import 'package:share/share.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  _ReferEarnState createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Refer & earn",  isTrue: true,
          size: 18,
          step: "1",
          color: Colors.transparent,
          textColor: pTextColor),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          height: Get.height,
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 2.0,
          ),
          child: body(),
        ),
      )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
              color: pPrimaryColor,
              isEnabled: true,
              tvSize: 16.0,
              height: 40.0,
              tvColor: Colors.white,
              radius: 12.0,
              btnTitle: "Share",
              onPress: () {
                Share.share(
                    'Hey, I am using Paytack for getting cashback. Sharing my referral code enjoy ${profileController.referralCode.toString()}');
              }),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        pVerticalSpace(height: 40.0),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: commonTextStyle(type: 'B2'),
              children: <TextSpan>[
                TextSpan(
                    text: 'Get ',
                    style: commonTextStyle(color: pTextColor, type: 'B1')),
                TextSpan(
                    text: '50 Kr ',
                    style: commonTextStyle(
                        color: pTextColor,
                        type: 'B1',
                        weight: FontWeight.bold)),
                TextSpan(
                    text:
                        'for each friend you refer to \npaytack app and they get 50 kr. too',
                    style: commonTextStyle(color: pTextColor, type: 'B1')),
              ],
            ),
          ),
        ),
        middleSection(),
      ],
    );
  }

  Widget middleSection() {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          pVerticalSpace(height: 40.0),
          Container(
              height: 100.0,
              width: 100.0,
              child: Image.asset(
                refer_earn,
                fit: BoxFit.contain,
              )),
          pVerticalSpace(height: 30.0),
          TView(
            title: "your referral codes",
            size: 16,
            color: pTextColor,
          ),
          pVerticalSpace(height: 15.0),
          GetBuilder<ProfileController>(builder: (profile) {
            return TView(
              title: profile.referralCode.toString(),
              size: 16,
              color: pPrimaryColor,
            );
          }),
          pVerticalSpace(height: 90.0),
          TView(
            title:
                "Refer as many friends as you can! \nThey just need to use this referral code during \nsign up.",
            size: 16,
            color: pTextColor,
          ),
        ],
      ),
    );
  }
}
