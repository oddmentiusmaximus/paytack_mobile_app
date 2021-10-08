import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/my_profile/application/profile_controller.dart';

class NeedHelp extends StatefulWidget {
  const NeedHelp({Key? key}) : super(key: key);

  @override
  _NeedHelpState createState() => _NeedHelpState();
}

class _NeedHelpState extends State<NeedHelp> {
  TextEditingController _textEditingController=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar("Help",  isTrue: true,
          size: 18,
          step: "1",
          color: Colors.transparent,
          textColor: pTextColor),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
        padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 2.0,
        ),
        child: body(),
      ),
          )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
              color: pPrimaryColor,
              isEnabled: true,
              tvSize: 16.0,
              height: 40.0,
              tvColor: Colors.white,
              radius: 12.0,
              btnTitle: "Send",
              onPress: () {
                Get.find<ProfileController>().submitFeedback(_textEditingController.text, context);
              }),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      // This makes each child fill the full width of the screen
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        pVerticalSpace(height: 80.0),
        TView(
          title: "We are happy to help you",
          size: 22,
          color: pTextColor,
          weight: FontWeight.bold,
        ),
        pVerticalSpace(height: 20.0),
        TView(
          title: "You can write the problem here or mail",
          size: 16,
          color: pTextColor,
        ),
        Align(
          alignment: Alignment.center,
          child: RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: commonTextStyle(type: 'B2'),
              children: <TextSpan>[
                TextSpan(
                    text: 'us at ',
                    style: commonTextStyle(color: pTextColor, type: 'B1')),
                TextSpan(
                    text: 'help@paytack.se',
                    style: commonTextStyle(color: pPrimaryColor, type: 'B1')),
              ],
            ),
          ),
        ),
        middleSection(),
      ],
    );
  }



  Widget middleSection() {
    return Expanded(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          pVerticalSpace(height: 60.0),
          Container(
              height: 90.0,
              width: 90.0,
              child: Image.asset(
                help_art,
                fit: BoxFit.contain,
              )),
          pVerticalSpace(height: 30.0),
          TInput(
            onChange: (val) {},
            hintText: "Tell us more. How can we help you?",
            type: 'B1',
            maxLines: 1,
            controller: _textEditingController,
            isEdit: false,
            isError: false,
            isInput: true,
            inputFormatters: [LengthLimitingTextInputFormatter(120)],
            keyboardType: TextInputType.name,
          ),
          pVerticalSpace(height: 15.0),
        ],
      ),
    );
  }

  Widget bottomBanner() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomButton(
              color: pPrimaryColor,
              isEnabled: true,
              tvSize: 16.0,
              height: 40.0,
              tvColor: Colors.white,
              radius: 12.0,
              btnTitle: "Send",
              onPress: () {}),
        ),
        pVerticalSpace(height: 10.0),
      ],
    );
  }
}
