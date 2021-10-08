import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/my_profile/application/profile_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ChangePinPage extends StatelessWidget {
  StreamController<ErrorAnimationType>? errorController;
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Change PIN",
          isTrue: true,
          size: 18,
          step: "1",
          color: Colors.transparent,
          textColor: pTextColor),
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
                          obscureText: profileController.showPin.isTrue,
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
                          controller: profileController.newPinController,
                          keyboardType: TextInputType.phone,
                          onCompleted: (v) {
                            print("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            print(value);
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
                          profileController.toggleObscureText(true, false);
                        },
                        child: Visibility(
                          visible: profileController.showPin.isTrue,
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
                            obscureText:
                                profileController.showConfirmPin.isTrue,
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
                            controller: profileController.confirmPinController,
                            keyboardType: TextInputType.phone,

                            onCompleted: (v) {
                              print("Completed");
                            },
                            // onTap: () {
                            //   print("Pressed");
                            // },
                            onChanged: (value) {
                              print(value);
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
                            profileController.toggleObscureText(false, true);
                          },
                          child: Visibility(
                            visible: profileController.showConfirmPin.isTrue,
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
                    btnTitle: "Update",
                    onPress: () {
                      if (profileController.newPinController!.text ==
                          profileController.confirmPinController!.text) {
                        profileController.setNewPin(context);
                      } else {
                        showToast(
                            msg: 'New Pin doesn\'t match the confirm Pin');
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
