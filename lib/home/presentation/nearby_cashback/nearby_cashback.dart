import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/permission.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:permission_handler/permission_handler.dart';

class NearByCashBack extends StatefulWidget {
  var callBack;

  NearByCashBack({Key? key, this.callBack}) : super(key: key);

  @override
  _NearByCashBackState createState() => _NearByCashBackState();
}

class _NearByCashBackState extends State<NearByCashBack> {
  static const String _kPermissionDeniedMessage = 'Permission denied.';

  final List<String> imageList = [
    "https://wallpapercave.com/wp/wp2253979.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  ];
  Position? _currentPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool permission = await PermissionHandle().checkPermissionStorage(
        context: context, permissionGroup: Permission.location);
    print("here");
    print(permission);
    if (permission == true) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      Get.find<DashBoardController>()
          .getNearBy(position.latitude, position.longitude);
    } else {
      Get.find<DashBoardController>().updateLoader(true);
      showCommonWithWidget(
          locationPopup: true,
          barrierDismissible: false,
          imageTrue: false,
          context: context,
          title: "Location disabled",
          message:
              'Please enable location services to find \nbest offers nearest to you',
          widget: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CustomButton(
                    color: pPrimaryColor,
                    isEnabled: true,
                    tvSize: 16.0,
                    width: 150,
                    tvColor: Colors.white,
                    height: 45.0,
                    radius: 12.0,
                    btnTitle: "Enable location",
                    onPress: () async {
                      await openAppSettings();
                      //PermissionHandle().permission();
                    }),
                pVerticalSpace(height: 15.0),
                InkWell(
                  onTap: () {
                    Get.find<DashBoardController>().updateLoader(true);
                    Get.back();
                  },
                  child: TView(
                    title: "Not now",
                    color: pPrimaryColor,
                    size: 14.0,
                  ),
                )
              ],
            ),
          ));
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var random = new Random();
    return RefreshIndicator(
      onRefresh: getCurrentLocation,
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // new
          child:
              GetBuilder<DashBoardController>(builder: (dashboardController) {
            return dashboardController.loader == false
                ? Center(
                    child: Container(
                      height: Get.height*0.4,
                        child: SpinKitRipple(
                      color: pPrimaryColor,
                      borderWidth: 7.0,
                    )),
                  )
                : dashboardController.listNearByBusiness.isEmpty
                    ? Container(
                        height: Get.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                not_found,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            pVerticalSpace(height: 10.0),
                            TView(
                                title: "Hard time finding your destination",
                                color: Colors.black,
                                weight: FontWeight.bold,
                                size: 20.0),
                            pVerticalSpace(height: 10.0),
                            TView(
                                title: "We are not yet operational near you.",
                                color: pTextColor,
                                size: 14.0),
                            pVerticalSpace(height: 10.0),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: widget.callBack == 1
                            ? dashboardController.listNearByBusiness.length < 3
                                ? dashboardController.listNearByBusiness.length
                                : 3
                            : dashboardController.listNearByBusiness.length,
                        physics: new NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          String cashback = dashboardController
                              .listNearByBusiness[index].discountPercenatage
                              .toString();
                          if (cashback == "null") {
                            cashback = "0";
                          }
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoute.detailPage,
                                  arguments: dashboardController
                                      .listNearByBusiness[index]);
                            },
                            child: Container(
                                margin: EdgeInsets.all(16.0),
                                child: Column(children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 25.0,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 35.0,
                                                  backgroundImage: dashboardController
                                                              .listNearByBusiness[
                                                                  index]
                                                              .logoUrl!
                                                              .isEmpty ||
                                                          dashboardController
                                                                  .listNearByBusiness[
                                                                      index]
                                                                  .logoUrl ==
                                                              "string"
                                                      ? NetworkImage(noImage)
                                                      : NetworkImage(
                                                          dashboardController
                                                              .listNearByBusiness[
                                                                  index]
                                                              .logoUrl!),
                                                ),
                                              ),
                                              pHorizontalSpace(width: 8.0),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    strutStyle: StrutStyle(
                                                        fontSize: 20.0),
                                                    text: TextSpan(
                                                        style:
                                                            commonTextStyle(),
                                                        text: dashboardController
                                                            .listNearByBusiness[
                                                                index]
                                                            .businessName),
                                                  ),
                                                  pVerticalSpace(height: 7.0),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        marker,
                                                        height: 15,
                                                        width: 15,
                                                      ),
                                                      pHorizontalSpace(
                                                        width: 5.0,
                                                      ),
                                                      TView(
                                                        title: dashboardController
                                                            .listNearByBusiness[
                                                                index]
                                                            .distance!
                                                            .toStringAsFixed(2)+" Km",
                                                        size: 14.0,
                                                        color:
                                                            pHomePageTextColor,
                                                      ),
                                                      pHorizontalSpace(
                                                        width: 5.0,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        size: 17,
                                                        color:
                                                            pHomePageTextColor,
                                                      ),
                                                      TView(
                                                        title: doubleInRange(
                                                                random,
                                                                3.5,
                                                                5.0)
                                                            .toStringAsFixed(1),
                                                        size: 14.0,
                                                        color:
                                                            pHomePageTextColor,
                                                      ),
                                                      pHorizontalSpace(
                                                        width: 5.0,
                                                      ),
                                                    ],
                                                  ),
                                                  pHorizontalSpace(width: 10.0),
                                                ],
                                              ),
                                            ],
                                          ),
                                          pVerticalSpace(height: 5.0),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                flash,
                                                height: 15,
                                                width: 15,
                                              ),
                                              pHorizontalSpace(
                                                width: 5.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  TView(
                                                    title: cashback +
                                                        " Extra Cashback",
                                                    size: 14.0,
                                                    color: pHomePageTextColor,
                                                  ),
                                                  TView(
                                                    title:
                                                        "No minimum purchase",
                                                    size: 14.0,
                                                    color: pHomePageTextColor,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          pVerticalSpace(height: 5.0),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                height: 90.0,
                                                width: 90.0,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  child: Image.network(
                                                    noImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          pVerticalSpace(height: 9.0),
                                        ],
                                      ),
                                    ],
                                  )
                                ])),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      );
          })),
    );
  }

  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
}
