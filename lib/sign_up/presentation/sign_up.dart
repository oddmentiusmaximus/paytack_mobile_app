import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:paytack/sign_up/application/controllers/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignupController _signUpController = Get.find();

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
                      pVerticalSpace(height: 25.0),
                      TInput(
                          controller: _signUpController.signUpName,
                          type: 'B1',
                          hintText: "Name*",
                          maxLines: 1,
                          isEdit: false,
                          isError: false,
                          isInput: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(240),
                          ],
                          keyboardType: TextInputType.name,
                          onChange: (val) {
                            if (val.isEmpty || GetUtils.isNumericOnly(val)) {
                              _signUpController.isNameError.value = true;
                            } else {
                              _signUpController.isNameError.value = false;
                            }
                          }),
                      pVerticalSpace(height: 5.0),
                      Obx(() {
                        return Visibility(
                            visible: _signUpController.isNameError.isTrue,
                            child: TView(
                              title: 'Please enter your Name',
                              size: 12,
                              color: pError,
                            ));
                      }),
                      pVerticalSpace(height: 25.0),
                      TInput(
                          controller: _signUpController.signUpEmail,
                          type: 'B1',
                          hintText: "Email*",
                          maxLines: 1,
                          isEdit: false,
                          isError: false,
                          isInput: true,
                          keyboardType: TextInputType.emailAddress,
                          onChange: (val) {
                            if (val.toString() == 'null' || val.isEmpty) {
                              _signUpController.isEmailError.value = true;
                            } else if (!GetUtils.isEmail(val)) {
                              _signUpController.isEmailError.value = true;
                            } else {
                              _signUpController.isEmailError.value = false;
                            }
                          }),
                      pVerticalSpace(height: 5.0),
                      Obx(() {
                        return Visibility(
                            visible: _signUpController.isEmailError.isTrue,
                            child: TView(
                              title: 'Please enter valid Email',
                              size: 12,
                              color: pError,
                            ));
                      }),
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
                      pVerticalSpace(height: 25.0),
                      TInput(
                        onChange: (val) {},
                        hintText: "Have a referral code? (Optional)",
                        type: 'B1',
                        maxLines: 1,
                        controller: _signUpController.signUpReferralCode,
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
                          height: 50.0,
                          radius: 12.0,
                          btnTitle: "Next",
                          onPress: () {
                            if (_signUpController.isEmailError.isFalse &&
                                _signUpController
                                    .signUpEmail!.text.isNotEmpty &&
                                _signUpController.isNameError.isFalse &&
                                _signUpController.signUpName!.text.isNotEmpty) {
                              _signUpController.checkEmail(context);
                            } else {
                              showToast(
                                  msg: 'Please Validate All Required Fields');
                            }
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
                                      weight: FontWeight.bold,
                                      color: pPrimaryColor,
                                      type: 'B2')),
                              new TextSpan(
                                  text: ' & ',
                                  style: commonTextStyle(
                                      color: pTextColor, type: 'B2')),
                              new TextSpan(
                                  text: 'Privacy Policy',
                                  style: commonTextStyle(
                                      weight: FontWeight.bold,
                                      color: pPrimaryColor,
                                      type: 'B2')),
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
                                    text: 'Don\'t have an account ?',
                                    style: commonTextStyle(
                                        color: pTextColor, type: 'B2')),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.offAllNamed(AppRoute.login);
                                      },
                                    text: ' Sign In ',
                                    style: commonTextStyle(
                                        weight: FontWeight.bold,
                                        color: pPrimaryColor,
                                        type: 'B2')),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]))),
      ],
    );
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
