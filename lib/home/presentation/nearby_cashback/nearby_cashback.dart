import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/routes/app_screens.dart';

class NearByCashBack extends StatelessWidget {
  final List<String> imageList = [
    "https://wallpapercave.com/wp/wp2253979.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  ];

  NearByCashBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var random = new Random();
    return SingleChildScrollView(
        child: ListView.separated(
      itemCount: 3,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.toNamed(AppRoute.detailPage, arguments: imageList[index]);
          },
          child: Container(
              margin: new EdgeInsets.all(16.0),
              child: new Column(children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(
                                    "https://i.etsystatic.com/23304690/r/il/77fca0/2328867732/il_fullxfull.2328867732_tunp.jpg"),
                              ),
                            ),
                            pHorizontalSpace(width: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  overflow: TextOverflow.ellipsis,
                                  strutStyle: StrutStyle(fontSize: 20.0),
                                  text: TextSpan(
                                      style: commonTextStyle(),
                                      text: "Burger King"),
                                ),
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
                                      title: "1.5KM",
                                      size: 14.0,
                                      color: pHomePageTextColor,
                                    ),
                                    pHorizontalSpace(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 17,
                                      color: pHomePageTextColor,
                                    ),
                                    TView(
                                      title: doubleInRange(random, 3.5, 5.0)
                                          .toStringAsFixed(1),
                                      size: 14.0,
                                      color: pHomePageTextColor,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TView(
                                  title: "5% Extra Cashback",
                                  size: 14.0,
                                  color: pHomePageTextColor,
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
                        pVerticalSpace(height: 5.0),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 90.0,
                              width: 90.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  imageList[index],
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
    ));
  }

  //we are generating random rating for now
  double doubleInRange(Random source, num start, num end) =>
      source.nextDouble() * (end - start) + start;
}
