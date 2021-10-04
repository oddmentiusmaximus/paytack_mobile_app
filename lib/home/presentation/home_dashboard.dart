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
                              size: 24,
                              color: pPrimaryColor,
                            ),
                            pHorizontalSpace(width: 10.0),
                            TView(
                              title: "Welcome, " +
                                  "${val.userName!.isNotEmpty ? val.userName!.replaceFirst(val.userName![0], val.userName![0].toUpperCase()) : '...'}",
                              color: pTextColors,
                              size: 17,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          pVerticalSpace(height: 15.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 0.0),
                            child: TView(
                              color: pHomePageTextColor,
                              title: "CASHBACK BALANCE",
                              size: 10,
                              letterSpacing: 1.5,
                              weight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 10.0, top: 0.0),
                            child: Row(
                              children: [
                                TView(
                                  size: 28.0,
                                  color: pTextColors,
                                  title: val.availableCashback.toString(),
                                  weight: FontWeight.bold,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: TView(
                                    size: 20.0,
                                    color: pTextColors,
                                    title: " Kr.",
                                    weight: FontWeight.normal,
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 40,
                                  width: 117,
                                  child: OutlineButtonCommon(
                                    btnTitle: "Redeem",
                                    tvSize: 13.0,
                                    height: 50.0,
                                    horizontalPadding: 5.0,
                                    verticalPadding: 15.0,
                                    btnColor: pPrimaryColor,
                                    icon: qr,
                                    color: pPrimaryColor,
                                    textColor: Colors.black,
                                    onPressed: () {
                                      val.scan(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                          pVerticalSpace(height: 25.0),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 0.0, top: 0.0),
                                child: TView(
                                  color: Colors.grey,
                                  title:
                                      val.pendingCashback.toString() + " Kr.",
                                  size: 13.0,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              pHorizontalSpace(width: 2.0),
                              TView(
                                title: "Cashback Pending",
                                color: pHomePageTextColor,
                                size: 13.0,
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(left: 80),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    TView(
                                      color: pPrimaryColor,
                                      title: "Know more",
                                      size: 13.0,
                                      weight: FontWeight.w600,
                                    ),
                                    pHorizontalSpace(width: 2.0),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15.0,
                                      color: pPrimaryColor,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),

                    pVerticalSpace(height: 20.0),
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
                                if (i == val.pageNoSlider)
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
                              color: pProgress,
                              size: 13.0,
                              weight: FontWeight.w800,
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
