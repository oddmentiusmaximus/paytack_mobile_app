import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/mytext.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double i = 0;

  @override
  Widget build(BuildContext context) {
    // give the current args from currentScreen
    String args = Get.arguments;
    i = (Get.height * 0.4) - 40;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
              args,
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
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: i),
                color: Colors.transparent,
                child: Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(35.0),
                          topRight: const Radius.circular(35.0),
                        )),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    new SizedBox(
                                      width: 65,
                                      height: 65,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          child: Image.network(
                                              "https://www.visitcurrituck.com/wp-content/uploads/2013/11/burger-king.png")),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TView(
                                          title: "Burger King",
                                          size: 20.0,
                                          color: Colors.black,
                                          weight: FontWeight.bold,
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
                                                  title: "1 KM",
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
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      Container(
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
                                      Padding(
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
                                    ],
                                  )),
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
                                title: "Fast food ",
                                size: 12.0,
                                color: Colors.black54,
                              ),
                              Text("      •  ",
                                  style: TextStyle(color: Colors.black54)),
                              TView(
                                title: "Jaggarvej 23, copenhagen",
                                size: 12.0,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 26.0, bottom: 20.0),
                          child: MaterialButton(
                            height: 55,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(12)),
                            onPressed: () {},
                            child: TView(
                              title: "Join Loyalty Program",
                              size: 19.0,
                              color: Colors.white,
                            ),
                            color: pPrimaryColor,
                          ),
                        ),
                        Row(
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
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Divider(color: Colors.grey),
                        ),
                        TView(
                            title: "Upto 5% Cashback",
                            size: 20.0,
                            color: pTextColor,
                            weight: FontWeight.bold),
                        Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: TView(
                              title: "No minimum purchase",
                              size: 12.0,
                              color: pTextColor,
                            )),
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
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 5,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            TView(
                                              title: "Monday - Friday",
                                              size: 14.0,
                                              color: pTextColor,
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  size: 15,
                                                ),
                                                pHorizontalSpace(width: 4.0),
                                                TView(
                                                  title: "10:00 - 07:00 PM",
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
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
