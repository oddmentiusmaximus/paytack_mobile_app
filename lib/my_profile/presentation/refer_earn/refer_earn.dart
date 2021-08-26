import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:share/share.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  _ReferEarnState createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Refer & earn", isTrue: true),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 2.0,
        ),
        child: body(),
      )),
    );
  }

  Widget body() {
    return Column(
      // This makes each child fill the full width of the screen
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
        bottomBanner(),
      ],
    );
  }

  Widget middleSection() {
    return Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          pVerticalSpace(height: 90.0),
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
          TView(
            title: "JOHN56",
            size: 16,
            color: pPrimaryColor,
          ),
          pVerticalSpace(height: 70.0),
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

  Widget bottomBanner() {
    return Column(
      children: [
        Padding(
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
                    'Hey, I am using Paytack for getting cashback. Sharing my referral code enjoy');
              }),
        ),
        pVerticalSpace(height: 10.0),
      ],
    );
  }
}
