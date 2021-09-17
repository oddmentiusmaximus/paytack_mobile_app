import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/food_detail_page/application/controllers/detail_page_controller.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:paytack/sign_up/application/controllers/signup_controller.dart';

class OptionalDetailsScreen extends StatefulWidget {
  const OptionalDetailsScreen({Key? key}) : super(key: key);

  @override
  _OptionalDetailsScreenState createState() => _OptionalDetailsScreenState();
}

class _OptionalDetailsScreenState extends State<OptionalDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            resizeToAvoidBottomInset: false,
            appBar: commonAppBar("",
                isTrue: true, size: 14, step: "1", color: Colors.transparent),
            body: GetBuilder<SignupController>(builder: (logic) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 2.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        TView(
                          title: "Few more details ",
                          size: 24.0,
                          weight: FontWeight.bold,
                          align: TextAlign.start,
                          isMaxLines: false,
                          isOverflow: false,
                          color: pTextColor,
                        ),
                        TView(
                          title: "(optional)",
                          size: 14.0,
                          weight: FontWeight.normal,
                          align: TextAlign.start,
                          isMaxLines: false,
                          isOverflow: false,
                          color: pTextColor,
                        ),
                      ],
                    ),
                    pVerticalSpace(height: 25.0),
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
                                logic.countryCode = value!.dialCode!;
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
                            controller: logic.optionalDetailsMobileNo,
                            isEdit: false,
                            isError: false,
                            isInput: true,
                            onChange: (val) {},
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10)
                            ],
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    pVerticalSpace(height: 10.0),
                    TView(
                      title: "We'll send you latest offers & best deals",
                      color: Colors.black38,
                      size: 12,
                    ),
                    pVerticalSpace(height: 25.0),
                    GestureDetector(
                      onTap: () {
                        _pickDateDialog()
                            .then((value) => logic.updateDate(true, value));
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: pDisable, width: 0.3),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            TView(
                              title: logic.birthdayDate,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spacer(),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black38,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                    pVerticalSpace(height: 10.0),
                    TView(
                      title: "We'll surprise you on your birthday",
                      color: Colors.black38,
                      size: 12,
                    ),
                    pVerticalSpace(height: 25.0),
                    GestureDetector(
                      onTap: () => _pickDateDialog()
                          .then((value) => logic.updateDate(false, value)),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: pDisable, width: 0.3),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            TView(
                              title: logic.anniversaryDate,
                              size: 16,
                              color: Colors.black38,
                            ),
                            Spacer(),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black38,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                    pVerticalSpace(height: 10.0),
                    TView(
                      title: "We'll make your special day more special",
                      color: Colors.black38,
                      size: 12,
                    ),
                    pVerticalSpace(height: 25.0),
                    TInput(
                      controller: logic.optionalDetailsCity,
                      hintText: 'City',
                      type: 'B1',
                      onChange: (val) {},
                    ),
                    pVerticalSpace(height: 10.0),
                    TView(
                      title: "We'll filter & show best offers around you",
                      color: Colors.black38,
                      size: 12,
                    ),
                    Spacer(),
                    CustomButton(
                        color: pPrimaryColor,
                        isEnabled: true,
                        tvSize: 16.0,
                        height: 40.0,
                        tvColor: Colors.white,
                        radius: 12.0,
                        btnTitle: "Next",
                        onPress: () {
                          logic.getSignIn(context);
                          // Get.toNamed(AppRoute.homeLanding);
                        }),
                    pVerticalSpace(height: 15.0),
                    CustomButton(
                        color: Colors.white,
                        isEnabled: true,
                        tvSize: 16.0,
                        height: 40.0,
                        radius: 12.0,
                        tvColor: pPrimaryColor,
                        btnTitle: "I'll add later",
                        onPress: () {
                          logic.getSignIn(context);

                          // Get.toNamed(AppRoute.homeLanding);
                        }),
                    pVerticalSpace(height: 15.0),
                  ],
                ),
              );
            })),
      ],
    );
  }

  Future<String> _pickDateDialog() async {
    var outputDate = '';
    await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return outputDate;
      }
      var outputFormat = DateFormat('yyyy-MM-dd');
      outputDate = outputFormat.format(pickedDate);
      return outputDate;
    });
    return outputDate.toString();
  }
}
