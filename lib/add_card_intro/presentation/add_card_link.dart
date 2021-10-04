import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/permissions_screen/application/controller.dart';
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
    return Stack(
      children: [
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
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 2.0,
                ),
                child: Column(
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
                      title:
                          "Link your bank to earn cashback \nevery time you spend. Simple.",
                      size: 15.0,
                      weight: FontWeight.normal,
                      align: TextAlign.start,
                      isMaxLines: false,
                      isOverflow: false,
                      color: pTextColor,
                    ),
                    pVerticalSpace(height: 20.0),
                    middleSection,
                    Column(
                      children: [
                        CustomButton(
                            color: pPrimaryColor,
                            isEnabled: true,
                            tvSize: 16.0,
                            height: 40.0,
                            tvColor: Colors.white,
                            radius: 12.0,
                            btnTitle: "Link",
                            onPress: () {
                              Get.put(PermissionsController()).isSignUp = true;
                              Get.toNamed(AppRoute.webview)!.then((value) {
                                String msg = '';
                                String icon = '';
                                if (value == 'Account Verification Failed') {
                                  msg = "Account Verification Failed";
                                  icon = error_icon;
                                } else {
                                  icon = success_tick;
                                  msg =
                                      "Congratulations Account Verification SuccessFully";
                                }
                                showCommonWithWidget(
                                  barrierDismissible: false,
                                  context: context,
                                  title: "",
                                  image: icon,
                                  message: msg,
                                  imageTrue: true,
                                  widget: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CustomButton(
                                        color: pPrimaryColor,
                                        isEnabled: true,
                                        tvSize: 16.0,
                                        width: 100,
                                        tvColor: Colors.white,
                                        height: 45.0,
                                        radius: 12.0,
                                        btnTitle: "Ok",
                                        onPress: () {
                                          Get.toNamed(AppRoute.permissions);
                                        }),
                                  ),
                                );
                              });
                            }),
                        pVerticalSpace(height: 15.0),
                        CustomButton(
                            color: Colors.white,
                            isEnabled: true,
                            tvSize: 16.0,
                            height: 40.0,
                            radius: 12.0,
                            tvColor: pPrimaryColor,
                            btnTitle: "I'll add later",
                            onPress: () {
                              Get.put(PermissionsController()).isSignUp = true;
                              Get.toNamed(AppRoute.permissions);
                            }),
                        pVerticalSpace(height: 15.0),
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
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
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
            fit: BoxFit.contain,
            height: 250.0,
            width: 250,
          ),
        ),
        pVerticalSpace(height: 15.0),
        Center(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: commonTextStyle(),
              children: <TextSpan>[
                new TextSpan(
                    text: 'Your bank will never be charged. ',
                    style: commonTextStyle(color: pTextColor, type: 'B2')),
                TextSpan(
                    text: 'Ever.',
                    style: commonTextStyle(
                        weight: FontWeight.bold,
                        color: pTextColor,
                        type: 'B2')),
              ],
            ),
          ),
        )
            // TView(
            //   title: "",
            //   size: 14.0,
            //   weight: FontWeight.normal,
            //   align: TextAlign.start,
            //   isMaxLines: false,
            //   isOverflow: false,
            //   color: pTextColor,
            // ),
            ),
        pVerticalSpace(height: 15.0),
      ],
    ),
  ),
);
