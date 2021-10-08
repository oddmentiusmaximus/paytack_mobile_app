import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/my_profile/application/profile_controller.dart';

class ChangePhoneNoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChangePhoneNoPageState();
}

class _ChangePhoneNoPageState extends State<ChangePhoneNoPage> {
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Change phone number",
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
          children: [
            pHorizontalSpace(width: 40.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    width: 100,
                    height: 45,
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        border: Border.all(color: pDisable, width: 0.3),
                        borderRadius: BorderRadius.circular(8)),
                    child: CountryCodePicker(
                      onChanged: print,
                      initialSelection: 'DK',
                      showFlag: true,
                      showCountryOnly: false,
                      padding: EdgeInsets.all(1),
                      showDropDownButton: false,
                      favorite: ['dk'],
                      builder: (value) {
                        profileController.countryCode = value!.dialCode!;
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Image.asset(
                                  'packages/country_code_picker/' +
                                      value.flagUri!,
                                  scale: 2.4,
                                ),
                              ),
                              TView(
                                title: value.dialCode!,
                                color: Colors.black,
                                size: 16,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: pDisable,
                                size: 20,
                              )
                            ],
                          ),
                        );
                      },
                      showOnlyCountryWhenClosed: true,
                      alignLeft: false,
                      hideMainText: true,
                      showFlagMain: true,
                    ),
                  ),
                ),
                pHorizontalSpace(width: 20.0),
                Expanded(
                  flex: 3,
                  child: TInput(
                    hintText: "Mobile number",
                    type: 'B1',
                    maxLines: 1,
                    controller: profileController.optionalDetailsMobileNo,
                    isEdit: false,
                    isError: false,
                    isInput: true,
                    onChange: (val) {},
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
                color: pPrimaryColor,
                isEnabled: true,
                tvSize: 16.0,
                height: 50.0,
                radius: 12.0,
                tvColor: Colors.white,
                btnTitle: "Update",
                onPress: () {
                  Get.find<ProfileController>().updatePhone(context);

                }),
            pVerticalSpace(height: 25.0),
          ],
        ),
      ),
    );
  }
}
