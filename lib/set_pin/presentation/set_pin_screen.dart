import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:paytack/sign_up/application/controllers/signup_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({Key? key}) : super(key: key);

  @override
  _SetPinScreenState createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  final SignupController _signupController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("", isTrue: true, size: 18),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pVerticalSpace(height: 12.0),
                TView(
                  title: "Secure your Data",
                  size: 24.0,
                  weight: FontWeight.bold,
                  align: TextAlign.start,
                  isMaxLines: false,
                  isOverflow: false,
                  color: pTextColor,
                ),
                pVerticalSpace(height: 40.0),
                TView(
                  title: "Create Pin",
                  color: Color(0xff1C1D3E),
                  size: 14.0,
                ),
                pVerticalSpace(height: 8.0),
                Obx(() {
                  return Row(
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
                          obscureText: _signupController.isCreatePin.value,
                          obscuringCharacter: '*',
                          blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            return null;
                          },
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              fieldOuterPadding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 2.0),
                              borderRadius: BorderRadius.circular(10),
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
                          errorAnimationController: errorController,
                          controller: _signupController.createPinController,
                          keyboardType: TextInputType.phone,
                          showCursor: false,
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
                        ),
                      ),
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          _signupController.toggleObscureText(true, false);
                        },
                        child: Visibility(
                          visible: _signupController.isCreatePin.isTrue,
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
                      )),
                      //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.green,child: Text("text 4"))),
                    ],
                  );
                }),
                pVerticalSpace(height: 15.0),
                TView(
                  title: "Confirm Pin",
                  color: Color(0xff1C1D3E),
                  size: 14.0,
                ),
                pVerticalSpace(height: 8.0),
                Obx(() {
                  return Row(
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
                            obscureText: _signupController.isConfirmPin.value,
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,

                            animationType: AnimationType.fade,
                            validator: (v) {
                              return null;
                            },

                            pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                fieldOuterPadding: EdgeInsets.symmetric(
                                    horizontal: 4.0, vertical: 2.0),
                                borderRadius: BorderRadius.circular(10),
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
                            errorAnimationController: errorController,
                            controller: _signupController.confirmPinController,
                            keyboardType: TextInputType.phone,

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
                        child: GestureDetector(
                          onTap: () {
                            _signupController.toggleObscureText(false, true);
                          },
                          child: Visibility(
                            visible: _signupController.isConfirmPin.isTrue,
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
                pVerticalSpace(height: 40.0),
                CustomButton(
                    color: pPrimaryColor,
                    tvColor: Colors.white,
                    isEnabled: true,
                    tvSize: 16.0,
                    height: 50.0,
                    radius: 12.0,
                    btnTitle: "Set PIN",
                    onPress: () {
                      if (_signupController
                              .createPinController!.text.isNotEmpty &&
                          _signupController.createPinController!.text.length ==
                              4 &&
                          _signupController
                              .confirmPinController!.text.isNotEmpty &&
                          _signupController.createPinController!.text.trim() ==
                              _signupController.confirmPinController!.text
                                  .trim() &&
                          _signupController.confirmPinController!.text.length ==
                              4) {
                        Get.toNamed(AppRoute.optionalDetails);
                      } else {
                        print(
                            _signupController.createPinController!.text.trim() +
                                "==" +
                                _signupController.confirmPinController!.text
                                    .trim());
                        showToast(msg: 'Confirm Pin Does Not Match');
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
