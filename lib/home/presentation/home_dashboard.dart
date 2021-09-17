import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/dropdown_with_icon.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/home/presentation/nearby_cashback/nearby_cashback.dart';
import 'package:paytack/intro_screen/presentation/slide_dots.dart';
import 'package:paytack/routes/app_screens.dart';

import 'slider_screen/carousel_screen.dart';

class HomeDashBoard extends StatefulWidget {
  const HomeDashBoard({Key? key}) : super(key: key);

  @override
  _HomeDashBoardState createState() => _HomeDashBoardState();
}

class _HomeDashBoardState extends State<HomeDashBoard> {
  List<String> filterList = ["Sort By", "Location", "CashBack"];
  static const platform = const MethodChannel("test_activity");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<DashBoardController>();
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<DashBoardController>(
              builder: (val) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Container(
                          color: Colors.white,
                          margin: MediaQuery.of(context).padding,
                          child: Row(
                            children: [
                              ImageIcon(
                                AssetImage(logo_mark),
                                color: pPrimaryColor,
                              ),
                              pHorizontalSpace(width: 10.0),
                              TView(
                                title: "Welcome," + " " + "${val.userName}",
                                color: pTextColors,
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 45.0, vertical: 5.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TView(
                                color: pHomePageTextColor,
                                title: "CASHBACK BALANCE",
                              ),
                              pVerticalSpace(height: 10.0),
                              TView(
                                size: 23.0,
                                color: pTextColors,
                                title: val.availableCashback.toString() + " kr",
                                weight: FontWeight.bold,
                              ),
                              pVerticalSpace(height: 15.0),
                              Row(
                                children: [
                                  TView(
                                    color: Colors.grey,
                                    title:
                                        val.pendingCashback.toString() + " kr.",
                                    size: 14.0,
                                    weight: FontWeight.bold,
                                  ),
                                  pHorizontalSpace(width: 2.0),
                                  TView(
                                    title: "Cashback Pending",
                                    color: pHomePageTextColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Container(
                                child: OutlineButtonCommon(
                                  btnTitle: "Redeem",
                                  tvSize: 14.0,
                                  height: 15.0,
                                  horizontalPadding: 1.0,
                                  verticalPadding: 1.0,
                                  btnColor: pPrimaryColor,
                                  icon: qr,
                                  color: pPrimaryColor,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    val.scan(context);
                                  },
                                ),
                              ),
                              /* Row(
                                children: [
                                  TView(
                                    color: Colors.grey,
                                    title:
                                        val.pendingCashback.toString() + " kr",
                                    size: 14.0,
                                    weight: FontWeight.bold,
                                  ),
                                  pHorizontalSpace(width: 10.0),
                                  Tooltip(
                                    key: key,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    textStyle:
                                        commonTextStyle(color: Colors.black),
                                    message:
                                        'Minimum 100kr cashback can be \ntransfer back into your bank account',
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => _onTap(key),
                                      child: Image.asset(
                                        help,
                                        height: 30.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              pVerticalSpace(height: 10.0),
                              TView(
                                title: "Pending Cashback",
                                color: pHomePageTextColor,
                              ),*/
                            ],
                          )
                        ],
                      ),
                    ),
                    pVerticalSpace(height: 10.0),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20.0, vertical: 5.0),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Expanded(
                    //         child: OutlineButtonCommon(
                    //           btnTitle: "Redeem",
                    //           tvSize: 14.0,
                    //           horizontalPadding: 1.0,
                    //           verticalPadding: 1.0,
                    //           btnColor: pPrimaryColor,
                    //           icon: qr,
                    //           textColor: Colors.black,
                    //           onPressed: () {
                    //             val.scan(context);
                    //           },
                    //         ),
                    //       ),
                    //       pHorizontalSpace(width: 5.0),
                    //       Expanded(
                    //         child: OutlineButtonCommon(
                    //           horizontalPadding: 1.0,
                    //           icon: bank,
                    //           verticalPadding: 1.0,
                    //           tvSize: 14.0,
                    //           btnColor: pPrimaryColor,
                    //           textColor: Colors.black,
                    //           btnTitle: "Cashout",
                    //           onPressed: () {
                    //             // _getNewActivity();
                    //             Get.toNamed(AppRoute.cashoutPage);
                    //             //Get.toNamed(AppRoute.addTinkCard);
                    //           },
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Carousel(),
                    Stack(
                      alignment: Alignment.center,
                      // alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, left: 15),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < 2; i++)
                                if (i == 0)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TView(
                            title: "Nearby Cashback",
                            color: pTextColors,
                            size: 16.0,
                            weight: FontWeight.bold,
                          ),
                          InkWell(
                            onTap: () {
                              //_getNewActivity();
                              Get.toNamed(AppRoute.nearByAll);
                            },
                            child: TView(
                              title: "VIEW ALL",
                              color: pPrimaryColor,
                              size: 16.0,
                              weight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    NearByCashBack(
                      callBack: 1,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }

  _getNewActivity() async {
    try {
      await platform.invokeMethod('startNewActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
