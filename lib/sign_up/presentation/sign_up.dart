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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Country? _selected;

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    return Scaffold(
        appBar: commonAppBar("", isTrue: true, size: 14, step: "1"),
        resizeToAvoidBottomInset: false,
        body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 2.0,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TView(
                    title: "Sign Up",
                    size: 24.0,
                    weight: FontWeight.bold,
                    align: TextAlign.start,
                    isMaxLines: false,
                    isOverflow: false,
                    color: pTextColor,
                  ),
                  pVerticalSpace(height: 15.0),

                  TInput(
                      controller: TextEditingController(),
                      type: 'B1',
                      hintText: "Name*",
                      maxLines: 1,
                      isEdit: false,
                      isError: false,
                      isInput: true,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      keyboardType: TextInputType.name,
                      onChange: (val) {
                        if (val.toString() != 'null' || val.isNotEmpty) {}
                      }),
                  pVerticalSpace(height: 15.0),
                  TInput(
                    controller: TextEditingController(),
                    type: 'B1',
                    hintText: "Email*",
                    maxLines: 1,
                    isEdit: false,
                    isError: false,
                    isInput: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  // pVerticalSpace(height: 15.0),
                  //  Row(
                  //   children: [
                  //     Container(
                  //       width: 80,
                  //       height: 40,
                  //       padding: EdgeInsets.all(1),
                  //       decoration: BoxDecoration(
                  //         border: Border(
                  //           bottom:
                  //               BorderSide(width: 1.0, color: pBorderGrey),
                  //         ),
                  //       ),
                  //       child: CountryCodePicker(
                  //         onChanged: print,
                  //         initialSelection: 'DK',
                  //         showFlag: true,
                  //         showCountryOnly: false,
                  //         padding: EdgeInsets.all(1),
                  //         showDropDownButton: false,
                  //         favorite: ['dk'],
                  //         builder: (value) {
                  //           return Container(
                  //             child: Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: Image.asset(
                  //                     'packages/country_code_picker/' +
                  //                         value!.flagUri!,
                  //                     scale: 2.1,
                  //                   ),
                  //                 ),
                  //                 Icon(
                  //                   Icons.keyboard_arrow_down_outlined,
                  //                   color: pDisable,
                  //                   size: 20,
                  //                 )
                  //               ],
                  //             ),
                  //           );
                  //         },
                  //         showOnlyCountryWhenClosed: false,
                  //         alignLeft: false,
                  //         hideMainText: true,
                  //         showFlagMain: true,
                  //       ),
                  //     ),
                  //     pHorizontalSpace(width: 5.0),
                  //     Expanded(
                  //       flex: 3,
                  //       child: TInput(
                  //         hintText: "Phone Number",
                  //         type: 'B1',
                  //         maxLines: 1,
                  //         isEdit: false,
                  //         isError: false,
                  //         isInput: true,
                  //         inputFormatters: [
                  //           LengthLimitingTextInputFormatter(10)
                  //         ],
                  //         keyboardType: TextInputType.number,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  pVerticalSpace(height: 15.0),
                  TInput(
                    hintText: "Have a referral code?(Optional)",
                    type: 'B1',
                    maxLines: 1,
                    isEdit: false,
                    isError: false,
                    isInput: true,
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    keyboardType: TextInputType.name,
                  ),
                  pVerticalSpace(height: 55.0),
                  CustomButton(
                      color: pPrimaryColor,
                      isEnabled: true,
                      tvSize: 16.0,
                      tvColor: Colors.white,
                      height: 40.0,
                      radius: 12.0,
                      btnTitle: "Next",
                      onPress: () {
                        Get.toNamed(AppRoute.addCard);
                      }),
                  pVerticalSpace(height: 30.0),
                  Center(
                    child: TView(
                      title: "By creating account you agree to our",
                      align: TextAlign.center,
                      color: pTextColor,
                      size: 14.0,
                    ),
                  ),
                  pVerticalSpace(height: 10.0),
                  Center(
                    child: RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: commonTextStyle(type: 'B2'),
                        children: <TextSpan>[
                          new TextSpan(
                              text: 'Terms & Conditions ',
                              style: commonTextStyle(
                                  color: pPrimaryColor, type: 'B2')),
                          new TextSpan(
                              text: 'and ',
                              style: commonTextStyle(
                                  color: pTextColor, type: 'B2')),
                          new TextSpan(
                              text: 'Privacy Policy',
                              style: commonTextStyle(
                                  color: pPrimaryColor, type: 'B2')),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RichText(
                        text: new TextSpan(
                          // Note: Styles for TextSpans must be explicitly defined.
                          // Child text spans will inherit styles from parent
                          style: commonTextStyle(),
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'Don\'t have an account ',
                                style: commonTextStyle(
                                    color: pTextColor, type: 'B2')),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed(AppRoute.login);
                                  },
                                text: '? Sign In ',
                                style: commonTextStyle(
                                    color: pPrimaryColor, type: "CAPTION")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ])));
  }

  void show() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        // optional. Shows phone code before the country name.
        onSelect: (Country country) {
          print('Select country: ${country.displayName}');
        });
  }
}
