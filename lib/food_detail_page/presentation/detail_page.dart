import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/food_detail_page/application/controllers/detail_page_controller.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/home/domain/near_by_model.dart';
import 'package:paytack/home/domain/opening_hours_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double i = 0;
  List<OpeningHours> listOpeningHours = [];
  DetailPageController _detailPageController = Get.find();
  DashBoardController dashboardController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var listNearByBusinessData = Get.arguments;
    _detailPageController.getLoyaltyProgramStatus(
        listNearByBusinessData.businessCashbackConfig.payTackUserId);
  }

  @override
  Widget build(BuildContext context) {
    // give the current args from currentScreen
    var listNearByBusiness = Get.arguments;
    // String jsonsDataString = response.body.toString(); // toString of Response's body is assigned to jsonDataString
    // String withoutEquals = listNearByBusiness.openingHours.replaceAll(RegExp("\ "), '');
    listOpeningHours.clear();

    String cashback = listNearByBusiness
        .businessCashbackConfig!.firstCashbackValue
        .toString();
    String extraCashback = listNearByBusiness
        .businessCashbackConfig!.extraCashbackValue
        .toString();

    if (listNearByBusiness.businessCashbackConfig!.cashbackType!
            .toLowerCase() ==
        "Percentage".toLowerCase()) {
      cashback = cashback + " %";
      extraCashback = extraCashback + " %";
    } else {
      cashback = cashback + " kr";
      extraCashback = extraCashback + " kr";
    }
    if (cashback == "null") {
      cashback = "0";
    }
    if (listNearByBusiness.openingHours == "string" ||
        listNearByBusiness.openingHours.isEmpty) {
      listOpeningHours = [];
    } else {
      var map = json.decode(listNearByBusiness.openingHours);
      /*var maps = json.decode(map);
      print(map);
*/

      map.forEach((key, value) {
        print(key);
        listOpeningHours.add(
            OpeningHours(day: key, start: value["start"], end: value["end"]));
      });
    }
    i = (Get.height * 0.4) - 40;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            listNearByBusiness.businessCashbackConfig!.image.isEmpty
                ? Image.network(
                    noImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: Get.height * 0.4,
                  )
                : Image.network(
                    listNearByBusiness.businessCashbackConfig!.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: Get.height * 0.4,
                  ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 1.0),
              child: MaterialButton(
                onPressed: () {
                  Get.back();
                },
                color: Colors.white,
                // Button color
                textColor: Colors.black,
                child: Icon(
                  Icons.arrow_back_ios_sharp,
                  size: 24,
                ),
                padding: EdgeInsets.all(13),
                shape: CircleBorder(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: i),
              color: Colors.transparent,
              child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(35.0),
                        topRight: const Radius.circular(35.0),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    new SizedBox(
                                      width: 65,
                                      height: 65,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          child: listNearByBusiness
                                                      .logoUrl!.isEmpty ||
                                                  listNearByBusiness.logoUrl ==
                                                      "string"
                                              ? Image.network(
                                                  noImage,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: Get.height * 0.4,
                                                )
                                              : Image.network(ApiHelpers
                                                      .baseUrl +
                                                  listNearByBusiness.logoUrl)),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 100.0,
                                          child: TView(
                                            title:
                                                listNearByBusiness.businessName,
                                            size: 20.0,
                                            isMaxLines: true,
                                            color: Colors.black,
                                            weight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_pin,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: TView(
                                                  title: listNearByBusiness
                                                      .distance
                                                      .toStringAsFixed(2),
                                                  size: 12.0,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                "  •  ",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.grey,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0),
                                                  child: TView(
                                                    title: "4.5",
                                                    size: 12.0,
                                                    color: Colors.grey,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String mobile = listNearByBusiness
                                          .phoneNumber
                                          .toString()
                                          .replaceAll('-', '');
                                      _makeLaunch(
                                          'tel://${mobile.replaceAll(' ', '')}');
                                    },
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: pPrimaryColor,
                                              style: BorderStyle.solid,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            color: Colors.white),
                                        child: Icon(
                                          Icons.call,
                                          size: 30,
                                          color: pPrimaryColor,
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // _makeLaunch(listNearByBusiness);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: pPrimaryColor,
                                                style: BorderStyle.solid,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              color: Colors.white),
                                          child: Icon(
                                            Icons.public,
                                            size: 30,
                                            color: pPrimaryColor,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            children: [
                              Text("  •  ",
                                  style: TextStyle(color: Colors.black54)),
                              TView(
                                title: listNearByBusiness.category,
                                size: 12.0,
                                color: Colors.black54,
                              ),
                              Text("      •  ",
                                  style: TextStyle(color: Colors.black54)),
                              Expanded(
                                child: TView(
                                  title: listNearByBusiness.address,
                                  size: 12.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Divider(color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () {
                            String googleUrl =
                                'https://www.google.com/maps/search/?api=1&query=${listNearByBusiness.latitude},${listNearByBusiness.longitude}';
                            _makeLaunch(googleUrl);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: pPrimaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TView(
                                title: "Get directions",
                                size: 18.0,
                                color: pPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Divider(color: Colors.grey),
                        ),
                        listNearByBusiness
                                    .businessCashbackConfig!.extraCashbackValue
                                    .toString()
                                    .isEmpty ||
                                listNearByBusiness.businessCashbackConfig!
                                        .extraCashbackValue
                                        .toString() ==
                                    '0'
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TView(
                                    title: "Upto $cashback Cashback",
                                    size: 14.0,
                                    weight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  TView(
                                    title: listNearByBusiness
                                                    .businessCashbackConfig!
                                                    .minimumQualifyingAmount ==
                                                0 ||
                                            listNearByBusiness
                                                    .businessCashbackConfig!
                                                    .minimumQualifyingAmount ==
                                                null
                                        ? "No minimum purchase"
                                        : "On minimum ${listNearByBusiness.businessCashbackConfig!.minimumQualifyingAmount} Purchase",
                                    size: 14.0,
                                    color: pHomePageTextColor,
                                  ),
                                ],
                              )
                            : Container(),
                        listNearByBusiness
                                    .businessCashbackConfig!.extraCashbackValue
                                    .toString()
                                    .isEmpty ||
                                listNearByBusiness.businessCashbackConfig!
                                        .extraCashbackValue
                                        .toString() ==
                                    '0'
                            ? Container()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      TView(
                                        title:
                                            extraCashback + " Extra Cashback",
                                        size: 14.0,
                                        weight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      TView(
                                        title: "No minimum purchase",
                                        size: 14.0,
                                        color: pHomePageTextColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                        Padding(
                          padding:
                              const EdgeInsets.only(top: 8.0, bottom: 16.0),
                          child: Divider(color: Colors.grey),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TView(
                                    title: "Opening hours",
                                    size: 20.0,
                                    color: pTextColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                pVerticalSpace(height: 10.0),
                                listOpeningHours.isEmpty
                                    ? Center(
                                        child: TView(
                                          title: "Opening Hours Not Added",
                                          color: pTextColor,
                                          size: 12,
                                        ),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: listOpeningHours.length,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  TView(
                                                    title:
                                                        listOpeningHours[index]
                                                            .day
                                                            .toString(),
                                                    size: 14.0,
                                                    color: pTextColor,
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .watch_later_outlined,
                                                        size: 15,
                                                      ),
                                                      pHorizontalSpace(
                                                          width: 4.0),
                                                      TView(
                                                        title: listOpeningHours[
                                                                    index]
                                                                .start
                                                                .toString() +
                                                            " - " +
                                                            listOpeningHours[
                                                                    index]
                                                                .end
                                                                .toString(),
                                                        size: 14.0,
                                                        color: pTextColor,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              pVerticalSpace(height: 15.0),
                                            ],
                                          );
                                        },
                                      ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TView(
                                    title: "About",
                                    color: pTextColor,
                                    size: 15.0,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                pVerticalSpace(height: 7.0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TView(
                                    align: TextAlign.start,
                                    title:
                                        "At Burger King we serve gourmet burgers. The menu consists of fresh ingredients. A tBurger King we serve gourmet burgers.",
                                    color: pTextColor,
                                    size: 15.0,
                                    weight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _makeLaunch(String url) async {
    if (await canLaunch(url) != null) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
