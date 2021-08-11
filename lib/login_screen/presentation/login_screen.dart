import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
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
  bool hasError = false;
  String currentText = "";

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

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
                        hintText: "Name",
                        maxLines: 1,
                        type: 'B1',
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
                              flex: 3,
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
                                    fieldWidth: 50,
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
                          Expanded(
                            flex: 1,
                            child: TView(
                              title: "Show",
                              color: pProgress,
                              size: 14.0,
                            ),
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
                          tvSize: 16.0,
                          tvColor: Colors.white,
                          height: 50.0,
                          radius: 12.0,
                          btnTitle: "Let's Go",
                          onPress: () {
                            Get.offAllNamed(AppRoute.homeLanding);
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
