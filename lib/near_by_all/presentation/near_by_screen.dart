import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/appbar.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/home/presentation/nearby_cashback/nearby_cashback.dart';

class NearByAll extends StatefulWidget {
  const NearByAll({Key? key}) : super(key: key);

  @override
  _NearByAllState createState() => _NearByAllState();
}

class _NearByAllState extends State<NearByAll> {
  List<String> filterList = ["SORT BY", "Location", "CashBack", "Category"];
  final _controller = Get.find<DashBoardController>();

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
                      title: "Near you",
                      color: pTextColors,
                      size: 18.0,
                      weight: FontWeight.bold,
                    ),
                    Spacer(),
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: pBorderGrey),
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
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.sort,
                                  color: pHomePageTextColor,
                                  size: 20,
                                ),
                              ),
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
                      offset: Offset(0, 48),
                      onSelected: (val) {
                        if (val.toString() != '0') {
                          _controller.sortIndexPos = int.parse(val.toString());
                        }
                      },
                      padding: EdgeInsets.zero,
                      itemBuilder: (context) {
                        return List.generate(4, (index) {
                          return PopupMenuItem(
                            height: 0,
                            value: index,
                            enabled: false,
                            padding: EdgeInsets.zero,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                PopupMenuItem(
                                  height: 00,
                                  padding: EdgeInsets.zero,
                                  child: ListTile(
                                    visualDensity: VisualDensity.compact,
                                    selectedTileColor:
                                        _controller.sortIndexPos == index
                                            ? pProgress.withOpacity(0.05)
                                            : Colors.transparent,
                                    selected: _controller.sortIndexPos == index
                                        ? true
                                        : false,
                                    dense: true,
                                    horizontalTitleGap: 1,
                                    minVerticalPadding: 0.0,
                                    contentPadding: EdgeInsets.zero,
                                    trailing: _controller.sortIndexPos == index
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.check,
                                              color: pProgress,
                                            ),
                                          )
                                        : Opacity(opacity: 0.0),
                                    title: Container(
                                      margin: EdgeInsets.zero,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      width: 125,
                                      child: TView(
                                        align: TextAlign.start,
                                        title: filterList[index],
                                        weight: index == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: pTextColors,
                                        size: index == 0 ? 11.0 : 14.0,
                                      ),
                                    ),
                                  ),
                                  value: index,
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
