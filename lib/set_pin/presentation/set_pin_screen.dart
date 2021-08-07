import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({Key? key}) : super(key: key);

  @override
  _SetPinScreenState createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Secure your Data",isTrue: true,size: 18),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TView(
                  title: "Create Pin",
                  color: Color(0xff1C1D3E),
                  size: 16.0,
                ),
                pVerticalSpace(height: 8.0),
                Row(
                  children: <Widget>[
                    //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.red,child: Text("text 1"))),
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
                          validator: (v) {

                              return null;

                          },

                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              fieldOuterPadding: EdgeInsets.symmetric(
                                  horizontal: 7.0, vertical: 2.0),
                              //borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              inactiveColor: pBorderGrey,
                              inactiveFillColor: Colors.white,
                              activeFillColor: Colors.white,
                              selectedFillColor: pPrimaryColor,
                              selectedColor: pPrimaryColor,
                              activeColor: pPrimaryColor),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
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
                        child: TView(
                      title: "Show",
                      color: pPrimaryColor,
                      size: 16.0,
                    )),
                    //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.green,child: Text("text 4"))),
                  ],
                ),
                TView(
                  title: "Confirm Pin",
                  color: Color(0xff1C1D3E),
                  size: 16.0,
                ),
                pVerticalSpace(height: 8.0),
                Row(
                  children: <Widget>[
                    //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.red,child: Text("text 1"))),
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
                          validator: (v) {
                         return null;
                          },

                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              fieldOuterPadding: EdgeInsets.symmetric(
                                  horizontal: 7.0, vertical: 2.0),
                              //borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              inactiveColor: pBorderGrey,
                              inactiveFillColor: Colors.white,
                              activeFillColor: Colors.white,
                              selectedFillColor: pPrimaryColor,
                              selectedColor: pPrimaryColor,
                              activeColor: pPrimaryColor),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: textEditingController,
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
                        child: TView(
                      title: "Show",
                      color: pPrimaryColor,
                      size: 16.0,
                    )),
                    //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.green,child: Text("text 4"))),
                  ],
                ),
                pVerticalSpace(height: 20.0),
                CustomButton(
                    color: pPrimaryColor,
                    isEnabled: true,
                    tvSize: 14.0,
                    height: 40.0,
                    radius: 12.0,
                    btnTitle: "Let's Go",
                    onPress: () {
                      Get.offAllNamed(AppRoute.homeLanding);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
