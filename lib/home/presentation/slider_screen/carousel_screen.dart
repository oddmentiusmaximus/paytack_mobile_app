import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:nordigen_integration/nordigen_integration.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/utils/loading_class.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/routes/app_screens.dart';

class Carousel extends StatefulWidget {
  Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _currentPage = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (logic) {
      return Container(
        height: 150,
        child: Swiper(
          onIndexChanged: (index) {
            logic.updateSlideDot(index);
          },
          itemBuilder: (BuildContext context, int index) {
            return index == 1
                ? Container(
                    padding: EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Container(
                        color: pSlider,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20.0),
                              child: TView(
                                title: "Upload bill to earn cashback",
                                color: Colors.white,
                                size: 14,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 5,
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            padding: EdgeInsets.only(
                                                left: 18, right: 8.0, top: 10),
                                            child: OutlineButtonCommon(
                                              horizontalPadding: 1.0,
                                              iconColor: pPrimaryColor,
                                              icon: camera,
                                              verticalPadding: 1.0,
                                              iconSize: 18,
                                              tvSize: 13.0,
                                              btnColor: pPrimaryColor,
                                              onPressed: () {
                                                showChoiceDialog(context);
                                              },
                                              textColor: pPrimaryColor,
                                              btnTitle: "Scan Bill",
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                              offer,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        pHorizontalSpace(width: 8.0)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Container(
                        color: pSlider1,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20.0),
                              child: TView(
                                title: "Add your bank and\n earn cashback",
                                color: pDisable,
                                size: 14,
                                align: TextAlign.start,
                                weight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                pVerticalSpace(height: 20.0),

                                Flexible(
                                  child: new Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 5,
                                          child: Container(
                                            width: 130,
                                            height: 52,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 18,
                                                  right: 8.0,
                                                  top: 20),
                                              child: OutlineButtonCommon(
                                                  isEnabled: true,
                                                  horizontalPadding: 0.0,
                                                  iconColor: pPrimaryColor,
                                                  verticalPadding: 5.0,
                                                  height: 100,
                                                  iconSize: 18,
                                                  tvSize: 13.0,
                                                  textColor: Colors.red,
                                                  btnColor: Colors.white,
                                                  fontWeight: FontWeight.bold,

                                                  // width: 90,
                                                  color: Colors.white,
                                                  btnTitle: "Add Now",
                                                  onPressed: () {
                                                    Get.toNamed(
                                                        AppRoute.nordiGen);
                                                  }),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            height: 100,
                                            width: 100,
                                            child: Image.asset(
                                              offer,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        pHorizontalSpace(width: 8.0)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          itemCount: 2,
          itemHeight: 150,
          scale: 0.9,
          autoplay: true,
          duration: 1000,
        ),
      );
    });
  }
}
