import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
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
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final LoginController _controller = Get.find();
  bool hasError = false;
  String currentText = "";

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("", isTrue: true, size: 14, step: "1"),
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
                    size: 18.0,
                    weight: FontWeight.bold,
                    align: TextAlign.start,
                    isMaxLines: false,
                    isOverflow: false,
                    color: pTextColor,
                  ),
                  pVerticalSpace(height: 14.0),
                  TInput(
                    hintText: "Name",
                    maxLines: 1,
                    isEdit: false,
                    isError: false,
                    isInput: true,
                    inputFormatters: [LengthLimitingTextInputFormatter(20)],
                    keyboardType: TextInputType.name,
                  ),
                  pVerticalSpace(height: 20.0),
                  TView(
                    title: "Enter Pin",
                    size: 14.0,
                    weight: FontWeight.normal,
                    align: TextAlign.start,
                    isMaxLines: false,
                    isOverflow: false,
                    color: pBottomNav,
                  ),
                  pVerticalSpace(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        mainAxisAlignment: MainAxisAlignment.start,
                        length: 4,
                        obscureText: true,
                        obscuringCharacter: '*',
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10.0),
                            fieldOuterPadding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 2.0),
                            //borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 45,
                            inactiveColor: pBorderGrey,
                            inactiveFillColor: Colors.white,
                            activeFillColor: Colors.white,
                            selectedFillColor: Colors.white,
                            selectedColor: pPrimaryColor,
                            activeColor: pPrimaryColor),

                        cursorColor: Colors.black,
                        animationDuration: Duration(milliseconds: 300),
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
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                      TView(
                        title: "Show",
                        color: pPrimaryColor,
                        size: 12.0,
                      ),
                      //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.green,child: Text("text 4"))),
                    ],
                  ),
                  TView(
                    title: "Forgot PIN?",
                    color: pPrimaryColor,
                    size: 14.0,
                  ),
                  pVerticalSpace(height: 50.0),
                  CustomButton(
                      color: pPrimaryColor,
                      isEnabled: true,
                      tvSize: 14.0,
                      tvColor: Colors.white,
                      height: 40.0,
                      radius: 12.0,
                      btnTitle: "Let's Go",
                      onPress: () {
                        _controller.getLogin();
                        //Get.offAllNamed(AppRoute.homeLanding);
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
                            text: 'Don\'t have an account ',
                            style: commonTextStyle(
                                color: pTextColor, type: "CAPTION")),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed(AppRoute.signUp);
                              },
                            text: '? Sign Up ',
                            style: commonTextStyle(
                                color: pPrimaryColor, type: "CAPTION")),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
