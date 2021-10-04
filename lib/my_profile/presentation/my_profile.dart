import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/secure_storage.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/my_profile/application/profile_controller.dart';
import 'package:paytack/my_profile/presentation/need_help/navigation.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class MyProfileTab extends StatelessWidget {
  final profileController = Get.find<ProfileController>();
  StreamController<ErrorAnimationType>? errorController;

  List<String> settingMenuList = [
    "Change phone number",
    "Choose Language",
    "Change PIN",
    "Payment details",
    "Permissions"
  ];
  List<String> settingIconList = [
    phone,
    language,
    change_pin,
    card,
    permission
  ];
  List<String> moreMenuList = [
    "Refer and earn",
    "Need help?",
    "Terms and conditions",
    "Sign out"
  ];
  List<String> moreIconList = [refer, help_menu, privacy, signOut];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          //minimum: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: MediaQuery.of(context).padding,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              logo_mark,
                              height: 50,
                              width: 35,
                              fit: BoxFit.contain,
                            ),
                          ),
                          GetBuilder<DashBoardController>(builder: (profile) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TView(
                                    title: profile.userName
                                            .toString()
                                            .isNotEmpty
                                        ? profile.userName
                                            .toString()
                                            .replaceFirst(
                                                profile.userName![0].toString(),
                                                profile.userName![0]
                                                    .toString()
                                                    .toUpperCase())
                                        : '...',
                                    color: pTextColor3,
                                    size: 20,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(children: [
                                    TView(
                                      title: profile.userEmail.toString(),
                                      color: pBottomNav,
                                      size: 12,
                                      weight: FontWeight.normal,
                                    ),
                                    pHorizontalSpace(width: 12.0),
                                    ImageIcon(
                                      AssetImage(edit),
                                      size: 14,
                                      color: Colors.black,
                                    ),
                                  ]),
                                )
                              ],
                            );
                          })
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: TView(
                  title: "Settings",
                  weight: FontWeight.bold,
                  color: pDisable,
                  size: 16,
                ),
              ),
              pVerticalSpace(),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: settingIconList.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 1,
                  indent: 70,
                  thickness: 0.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      switch (index) {
                        case 0:
                          verifyPinPopUp(context,
                              route: AppRoute.changePhoneNo);
                          break;
                        case 1:
                          break;
                        case 2:
                          verifyPinPopUp(context, route: AppRoute.changePin);
                          break;
                        case 3:
                          break;
                        case 4:
                          verifyPinPopUp(context, route: AppRoute.permissions);
                          break;
                        default:
                          break;
                      }
                    },
                    title: TView(
                      title: settingMenuList[index],
                      align: TextAlign.start,
                      color: pTextColor3,
                      size: 14.0,
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset(
                        settingIconList[index],
                        color: pBottomNav,
                        fit: BoxFit.cover,
                        height: 18.0,
                      ),
                    ),
                  );
                },
              ),
            ]),
            Divider(
              height: 10,
              thickness: 10,
              color: dividerColor,
            ),

            // pVerticalSpace(height: 10.0),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                child: TView(
                  title: "More",
                  weight: FontWeight.bold,
                  color: pDisable,
                  size: 16,
                ),
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: moreIconList.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 1,
                  indent: 70,
                  thickness: 0.5,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      if (moreMenuList[index] == "Sign out") {
                        actionPopup(
                            context: context,
                            icon: ImageIcon(
                              AssetImage(signOut),
                              color: Colors.red,
                              size: 70.0,
                            ),
                            message: "Are you sure you want to sign out?",
                            rightButtonText: "Yes",
                            leftButtonText: "No",
                            rightBtnCallBack: () async {
                              //Get.back(canPop: true, closeOverlays: true);
                              await CommonStorage.delete();
                              Navigator.of(context, rootNavigator: true).pop();
                              Get.offAllNamed(AppRoute.login);
                            },
                            leftBtnCallBack: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              //Get.back(result: "hi");
                            });
                      } else {
                        Get.toNamed(navigation[index]['route']);
                      }
                    },
                    title: TView(
                      title: moreMenuList[index],
                      align: TextAlign.start,
                      color: pTextColor3,
                      size: 14.0,
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Image.asset(
                        moreIconList[index],
                        fit: BoxFit.cover,
                        height: 18.0,
                      ),
                    ),
                  );
                },
              ),
              Divider(
                height: 1,
                indent: 70,
                thickness: 0.5,
              ),
            ])
          ],
        ),
      )),
    );
  }

  verifyPinPopUp(
    BuildContext context, {
    required String route,
  }) {
    return showCommonWithWidget(
        imageTrue: false,
        context: context,
        widget: Column(
          children: [
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.red,child: Text("text 1"))),
                  Expanded(
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      mainAxisAlignment: MainAxisAlignment.start,
                      length: 4,
                      obscureText: profileController.popUpVerifyPin.isTrue,
                      obscuringCharacter: '*',
                      blinkWhenObscuring: true,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        return null;
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldOuterPadding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          inactiveColor: pBorderGrey,
                          inactiveFillColor: Colors.white,
                          activeFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          selectedColor: pPrimaryColor,
                          activeColor: pPrimaryColor),
                      autoDisposeControllers: false,
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: profileController.popUpPinController,
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
                  GestureDetector(
                    onTap: () {
                      profileController.popUpVerifyPin.value =
                          !profileController.popUpVerifyPin.value;
                    },
                    child: Visibility(
                      visible: profileController.popUpVerifyPin.isTrue,
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
                  //Expanded(child: Container(padding: EdgeInsets.all(16),color: Colors.green,child: Text("text 4"))),
                ],
              );
            }),
            pVerticalSpace(height: 25.0),
            CustomButton(
              color: pPrimaryColor,
              tvColor: Colors.white,
              isEnabled: true,
              tvSize: 16.0,
              radius: 12.0,
              width: 120.0,
              height: 45.0,
              btnTitle: 'Confirm',
              onPress: () async {
                var pin =
                    await CommonStorage.readSecureStorageData(login_pin_key);
                if (profileController.popUpPinController!.text.trim() == pin) {
                  Get.back();
                  Get.toNamed(route);
                  profileController.popUpPinController!.clear();
                } else {
                  profileController.popUpPinController!.clear();
                  showToast(msg: 'Enter a Valid Pin');
                }
              },
            ),
            pVerticalSpace(height: 15.0),
          ],
        ),
        title: 'Enter your PIN',
        message: '');
  }
}
