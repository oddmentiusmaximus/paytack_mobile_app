import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/routes/app_screens.dart';

class AddCardIntro extends StatefulWidget {
  const AddCardIntro({Key? key}) : super(key: key);

  @override
  _AddCardIntroState createState() => _AddCardIntroState();
}

class _AddCardIntroState extends State<AddCardIntro> {
  Country? _selected;

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    return Scaffold(
        appBar: commonAppBar("", isTrue: true, size: 14, step: "1"),
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 2.0,
          ),
          child: body,
        ));
  }
}

Widget middleSection = new Expanded(
  child: new Container(
    padding: new EdgeInsets.all(8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Image.asset(
            add_card,
            fit: BoxFit.cover,
            height: 120.0,
          ),
        ),
        pVerticalSpace(height: 15.0),
        Center(
          child: TView(
            title: "Your bank will never be charged. Ever.",
            size: 14.0,
            weight: FontWeight.normal,
            align: TextAlign.start,
            isMaxLines: false,
            isOverflow: false,
            color: pTextColor,
          ),
        ),
        pVerticalSpace(height: 10.0),
      ],
    ),
  ),
);

Widget bottomBanner = Column(
  children: [
    CustomButton(
        color: pPrimaryColor,
        isEnabled: true,
        tvSize: 16.0,
        height: 40.0,
        tvColor: Colors.white,
        radius: 12.0,
        btnTitle: "Next",
        onPress: () {
          //Get.toNamed(AppRoute.addCard);
        }),
    pVerticalSpace(height: 14.0),
    CustomButton(
        color: Colors.white,
        isEnabled: true,
        tvSize: 16.0,
        height: 40.0,
        radius: 12.0,
        tvColor: pPrimaryColor,
        btnTitle: "I'll add later",
        onPress: () {
          //Get.toNamed(AppRoute.addCard);
        }),
    pVerticalSpace(height: 10.0),
    TView(
      title: "PayTack commitment to security",
      size: 14.0,
      weight: FontWeight.bold,
      align: TextAlign.start,
      isMaxLines: false,
      isOverflow: false,
      color: pPrimaryColor,
    ),
    pVerticalSpace(height: 10.0),
  ],
);

Widget body = new Column(
  // This makes each child fill the full width of the screen
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    TView(
      title: "Link to earn",
      size: 24.0,
      weight: FontWeight.bold,
      align: TextAlign.start,
      isMaxLines: false,
      isOverflow: false,
      color: pTextColor,
    ),
    pVerticalSpace(height: 15.0),
    TView(
      title: "Link your bank to earn cashback \nevery time you spend. Simple.",
      size: 15.0,
      weight: FontWeight.normal,
      align: TextAlign.start,
      isMaxLines: false,
      isOverflow: false,
      color: pTextColor,
    ),
    pVerticalSpace(height: 20.0),
    middleSection,
    bottomBanner,
  ],
);
