import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/my_profile/application/profile_controller.dart';

class ChangeEmailID extends StatelessWidget {
  ChangeEmailID({Key? key}) : super(key: key);
  final profileController = Get.find<ProfileController>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Change email",
          isTrue: true,
          size: 18,
          step: "1",
          color: Colors.transparent,
          textColor: pTextColor),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 2.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pHorizontalSpace(width: 40.0),
            TInput(
              hintText: "Enter new email",
              type: 'B1',
              maxLines: 1,
              controller: profileController.editEmail,
              isEdit: false,
              isError: false,
              isInput: true,
              onChange: (val) {
                if (val.toString() == 'null' || val.isEmpty) {
                  profileController.isEmailError.value = true;
                } else if (!GetUtils.isEmail(val)) {
                  profileController.isEmailError.value = true;
                } else {
                  profileController.isEmailError.value = false;
                }
              },
              keyboardType: TextInputType.emailAddress,
            ),
            pVerticalSpace(height: 5.0),
            Obx(() {
              return Visibility(
                  visible: profileController.isEmailError.isTrue,
                  child: TView(
                    align: TextAlign.start,
                    title: 'Please enter valid Email',
                    size: 12,
                    color: pError,
                  ));
            }),
            Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                isLoading
                    ? CircularProgressIndicator(
                        color: pPrimaryColor,
                      )
                    : CustomButton(
                        color: pPrimaryColor,
                        isEnabled: true,
                        tvSize: 16.0,
                        height: 50.0,
                        radius: 12.0,
                        tvColor: Colors.white,
                        btnTitle: "Update",
                        onPress: () {
                          if (profileController.isEmailError.isFalse) {
                            Get.find<ProfileController>().updateEmail(context);
                          }
                          isLoading = true;
                        })
              ],
            ),
            pVerticalSpace(height: 25.0),
          ],
        ),
      ),
    );
  }
}
