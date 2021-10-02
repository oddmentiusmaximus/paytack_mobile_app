import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/login_screen/application/controllers/login_controller.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController _loginController = Get.find();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage(background_image), fit: BoxFit.fill),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,

          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pVerticalSpace(height: 12.0),
                      TView(
                        title: "Sign In",
                        size: 24.0,
                        weight: FontWeight.bold,
                        align: TextAlign.start,
                        isMaxLines: false,
                        isOverflow: false,
                        color: pTextColor,
                      ),
                      pVerticalSpace(height: 14.0),
                      TInput(
                          controller: _loginController.loginEmailController,
                          hintText: "Email",
                          maxLines: 1,
                          type: 'B1',
                          isEdit: false,
                          isError: false,
                          isInput: true,
                          keyboardType: TextInputType.emailAddress,
                          onChange: (val) {
                            if (val.toString() == 'null' || val.isEmpty) {
                              _loginController.isEmailError.value = true;
                            } else if (!GetUtils.isEmail(val)) {
                              _loginController.isEmailError.value = true;
                            } else {
                              _loginController.isEmailError.value = false;
                            }
                          }),
                      Obx(() {
                        return Visibility(
                            visible: _loginController.isEmailError.isTrue,
                            child: Column(
                              children: [
                                pVerticalSpace(height: 5.0),
                                TView(
                                  title: 'Please enter valid Email',
                                  size: 12,
                                  color: pError,
                                ),
                              ],
                            ));
                      }),
                      pVerticalSpace(height: 20.0),
                      TView(
                        title: "Enter PIN",
                        size: 14.0,
                        weight: FontWeight.normal,
                        align: TextAlign.start,
                        isMaxLines: false,
                        isOverflow: false,
                        color: pBottomNav,
                      ),
                      pVerticalSpace(height: 5.0),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 3,
                                child: PinCodeTextField(
                                  appContext: context,
                                  controller:
                                      _loginController.loginPinController,
                                  pastedTextStyle: TextStyle(
                                    color: Colors.green.shade600,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  length: 4,
                                  obscureText: _loginController.isPin.value,
                                  obscuringCharacter: '*',
                                  blinkWhenObscuring: true,
                                  showCursor: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(10.0),
                                      fieldOuterPadding: EdgeInsets.symmetric(
                                          horizontal: 4.0, vertical: 2.0),
                                      //borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 50,
                                      inactiveColor: pBorderGrey,
                                      inactiveFillColor: Colors.white,
                                      activeFillColor: Colors.white,
                                      selectedFillColor: Colors.white,
                                      selectedColor: pPrimaryColor,
                                      activeColor: pPrimaryColor),

                                  cursorColor: Colors.black,
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  enableActiveFill: true,

                                  // errorAnimationController: errorController,
                                  // controller: textEditingController,
                                  keyboardType: TextInputType.number,
                                  onCompleted: (v) {
                                    print("Completed");
                                  },
                                  // onTap: () {
                                  //   print("Pressed");
                                  // },
                                  onChanged: (value) {

                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                )),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  _loginController.toggleObscureText();
                                },
                                child: Visibility(
                                  visible: _loginController.isPin.isTrue,
                                  replacement: TView(
                                    title: "Hide",
                                    color: pProgress,
                                    size: 14.0,
                                  ),
                                  child: TView(
                                    title: "Show",
                                    color: pProgress,
                                    size: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.green,child: Text("text 4"))),
                          ],
                        );
                      }),
                      InkWell(
                        onTap: () {
                          showCommonWithWidget(
                            barrierDismissible: false,
                            context: context,
                            title: "Forgot PIN",
                            message:
                                "Enter your registered email and we \nwill send you your PIN to your email",
                            widget: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Obx(() {
                                  return Column(
                                    children: [
                                      TInput(
                                          controller: _loginController
                                              .forgotPinEmailController,
                                          hintText: "Email",
                                          maxLines: 1,
                                          type: 'B1',
                                          isEdit: false,
                                          isError: false,
                                          isInput: true,
                                          keyboardType: TextInputType.emailAddress,
                                          onChange: (val) {
                                            if (val.toString() == 'null' ||
                                                val.isEmpty) {
                                              _loginController
                                                  .isEmailForgotError
                                                  .value = true;
                                            } else if (!GetUtils.isEmail(val)) {
                                              _loginController
                                                  .isEmailForgotError
                                                  .value = true;
                                            } else {
                                              _loginController
                                                  .isEmailForgotError
                                                  .value = false;
                                            }
                                          }),
                                      Visibility(
                                          visible: _loginController
                                              .isEmailForgotError.isTrue,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              pVerticalSpace(height: 5.0),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: TView(
                                                  title:
                                                      'Please enter valid Email',
                                                  size: 12,
                                                  color: pError,
                                                ),
                                              ),
                                            ],
                                          )),
                                      pVerticalSpace(height: 30.0),
                                      CustomButton(
                                          color: pPrimaryColor,
                                          isEnabled: true,
                                          tvSize: 16.0,
                                          tvColor: Colors.white,
                                          height: 45.0,
                                          radius: 12.0,
                                          width: 120.0,
                                          btnTitle: "Send",
                                          onPress: () {
                                            if (_loginController
                                                    .forgotPinEmailController!
                                                    .text
                                                    .isNotEmpty &&
                                                _loginController
                                                    .isEmailForgotError
                                                    .isFalse) {
                                              _loginController.resetPin(context);
                                            } else {
                                              showToast(msg: "Enter Email Id");
                                            }
                                          }),
                                    ],
                                  );
                                })),
                          );
                        },
                        child: TView(
                          title: "Forgot PIN?",
                          color: pPrimaryColor,
                          size: 14.0,
                        ),
                      ),
                      pVerticalSpace(height: 50.0),
                      CustomButton(
                          color: pPrimaryColor,
                          isEnabled: true,
                          tvSize: 16.0,
                          tvColor: Colors.white,
                          height: 50.0,
                          radius: 12.0,
                          btnTitle: "Let's Go",
                          onPress: () {
                            if (_loginController.loginEmailController!.text
                                    .trim()
                                    .isNotEmpty &&
                                _loginController.isEmailError.isFalse &&
                                _loginController
                                    .loginPinController!.text.isNotEmpty &&
                                _loginController
                                        .loginPinController!.text.length ==
                                    4) {
                              _loginController.getLogin(context);
                            } else {
                              showToast(
                                  msg: 'Please Validate all required Fields');
                              // Get.offAllNamed(AppRoute.homeLanding);
                            }
                          }),
                      pVerticalSpace(height: 20.0),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
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
                                    color: pTextColor, type: "B2")),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offAllNamed(AppRoute.signUp);
                                  },
                                text: ' Sign Up ',
                                style: commonTextStyle(
                                    weight: FontWeight.bold,
                                    color: pPrimaryColor,
                                    type: "B2")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
