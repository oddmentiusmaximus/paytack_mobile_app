import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/secure_storage.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/routes/app_screens.dart';

class MyProfileTab extends StatelessWidget {
  MyProfileTab({Key? key}) : super(key: key);
  List<String> settingMenuList = [
    "Change phone number",
    "Choose Language",
    "Change PIN",
    "Payment details"
  ];
  List<String> settingIconList = [phone, language, change_pin, card];
  List<String> moreMenuList = [
    "Refer and earn",
    "Need help?",
    "Terms and conditions",
    "Sign out"
  ];
  List<String> moreIconList = [refer, help, privacy, signOut];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            pVerticalSpace(height: 10.0),
            Card(
              elevation: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        color: Colors.white,
                        margin: MediaQuery.of(context).padding,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ImageIcon(
                                  AssetImage(logo_mark),
                                  color: pPrimaryColor,
                                ),
                                pHorizontalSpace(width: 10.0),
                                TView(
                                  title: "John Doe",
                                  color: pTextColors,
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                            Row(children: [
                              pHorizontalSpace(width: 30.0),
                              TView(
                                title: "john@gmail.com",
                                color: pBorderGrey,
                                size: 12,
                                weight: FontWeight.normal,
                              ),
                              pHorizontalSpace(width: 10.0),
                              ImageIcon(
                                AssetImage(edit),
                                size: 15,
                                color: pBorderGrey,
                              ),
                            ])
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TView(
                        title: "Settings",
                        weight: FontWeight.bold,
                        color: pTextColors,size: 16,
                      ),
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: settingIconList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 1,
                        indent: 70,
                        thickness: 0.5,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: TView(
                            title: settingMenuList[index],
                            align: TextAlign.start,
                            color: pTextColors,
                            size: 14.0,
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Image.asset(
                              settingIconList[index],
                              fit: BoxFit.cover,
                              height: 18.0,
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(height: 1)
                  ]),
            ),
            pVerticalSpace(height: 10.0),
            Card(
              elevation: 2,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TView(
                        title: "More",
                        weight: FontWeight.bold,
                        color: pTextColors,size: 16,
                      ),
                    ),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: moreIconList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Get.offAllNamed(AppRoute.login);
                                  },
                                  leftBtnCallBack: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    //Get.back(result: "hi");
                                  });
                            }
                          },
                          title: TView(
                            title: moreMenuList[index],
                            align: TextAlign.start,
                            color: pTextColors,
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
                    Divider(height: 1)
                  ]),
            )
          ],
        ),
      )),
    );
  }
}
