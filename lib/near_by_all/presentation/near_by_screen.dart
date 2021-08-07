import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/presentation/nearby_cashback/nearby_cashback.dart';
import 'package:paytack/routes/app_screens.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class NearByAll extends StatefulWidget {
  const NearByAll({Key? key}) : super(key: key);

  @override
  _NearByAllState createState() => _NearByAllState();
}

class _NearByAllState extends State<NearByAll> {
  List<String> filterList = ["Sort By", "Location", "CashBack"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 22,
                        )),
                    TView(
                      title: "Near You",
                      color: pTextColors,
                      size: 16.0,
                      weight: FontWeight.bold,
                    ),
                    Spacer(),
                    PopupMenuButton(
                      initialValue: 2,
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: pHomePageTextColor),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.filter_list_outlined,
                                  color: pHomePageTextColor),
                              TView(
                                title: "Cashback",
                                color: pTextColors,
                                size: 14.0,
                              ),
                              Icon(Icons.arrow_drop_down_sharp,
                                  color: pHomePageTextColor),
                            ],
                          ),
                        ),
                      )),
                      offset: Offset(0, 40),
                      itemBuilder: (context) {
                        return List.generate(2, (index) {
                          return PopupMenuItem(
                            value: index,
                            child: Column(
                              children: [
                                index == 0
                                    ? TView(
                                        title: "Sort By",
                                        color: pTextColors,
                                        size: 15.0,
                                      )
                                    : TView(
                                        title: filterList[index],
                                        color: pTextColors,
                                        size: 15.0,
                                      ),
                              ],
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
              NearByCashBack(),
            ],
          ),
        ),
      ),
    );
  }
}
