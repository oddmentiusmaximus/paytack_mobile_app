import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyOtpScreen extends StatefulWidget {
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  String _code = "";
  String signature = "{{ app signature }}";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton.extended(
      //     splashColor: Colors.white,
      //     backgroundColor: Colors.white,
      //     isExtended: true,
      //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //     elevation: 0,
      //     onPressed: () {},
      //     label: RichText(
      //       text: new TextSpan(
      //         // Note: Styles for TextSpans must be explicitly defined.
      //         // Child text spans will inherit styles from parent
      //         style: commonTextStyle(),
      //         children: <TextSpan>[
      //           new TextSpan(
      //               text: 'Already have an account? ',
      //               style: commonTextStyle(color: pTextColor, type: "B2")),
      //           new TextSpan(
      //               text: 'Sign In',
      //               style:
      //                   commonTextStyle(weight: FontWeight.bold,
      //                       color: pPrimaryColor, type: "B2")),
      //         ],
      //       ),
      //     )),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: commonAppBar("Verify your number", isTrue: true, size: 18),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 8.0,
        ),
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                pVerticalSpace(height: 20.0),
                TView(
                  title: "An OTP has been sent to ",
                  size: 15.0,
                  weight: FontWeight.normal,
                  align: TextAlign.start,
                  isMaxLines: false,
                  isOverflow: false,
                  color: pPhoneText,
                ),
                TView(
                  title: "+46-1234567890",
                  size: 15.0,
                  weight: FontWeight.bold,
                  align: TextAlign.start,
                  isMaxLines: false,
                  isOverflow: false,
                  color: pPhoneText,
                ),
                pVerticalSpace(height: 20.0),
                TView(
                  title: "Enter OTP",
                  size: 16.0,
                  weight: FontWeight.w300,
                  align: TextAlign.start,
                  isMaxLines: false,
                  isOverflow: false,
                  color: pTextColor,
                ),
                PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    colorBuilder:
                        FixedColorBuilder(Colors.black.withOpacity(0.3)),
                  ),
                  currentCode: _code,
                  codeLength: 5,
                  keyboardType: TextInputType.number,
                  onCodeSubmitted: (code) {},
                  onCodeChanged: (code) {
                    if (code!.length == 5) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
                pVerticalSpace(height: 50.0),
                CustomButton(
                    color: pPrimaryColor,
                    isEnabled: true,
                    tvSize: 16.0,
                    height: 40.0,
                    radius: 12.0,
                    btnTitle: "Verify",
                    tvColor: Colors.white,
                    onPress: () {
                      Get.toNamed(AppRoute.setPin);
                    }),
                pVerticalSpace(height: 20.0),
                Center(
                  child: RichText(
                    text: new TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: commonTextStyle(),
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'Didn\'t receive OTP?',
                            style:
                                commonTextStyle(color: pTextColor, type: "B2")),
                        new TextSpan(
                            text: ' Resend',
                            style: commonTextStyle(
                                weight: FontWeight.bold,
                                color: pPrimaryColor,
                                type: "B2")),
                      ],
                    ),
                  ),
                ),
              ],
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
                          text: 'Already have an account? ',
                          style:
                              commonTextStyle(color: pTextColor, type: 'B2')),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAllNamed(AppRoute.login);
                            },
                          text: 'Sign In',
                          style: commonTextStyle(
                              color: pPrimaryColor, type: "B2",weight: FontWeight.bold)),
                    ],
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
