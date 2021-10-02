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
                          color: pDisable,
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: new Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: OutlineButtonCommon(
                                      horizontalPadding: 1.0,
                                      icon: camera,
                                      verticalPadding: 1.0,
                                      tvSize: 14.0,
                                      btnColor: Colors.white,
                                      onPressed: () {
                                        showChoiceDialog(context);
                                      },
                                      textColor: Colors.black,
                                      btnTitle: "Scan Bill",
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      offer,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                          title: "Add your bank \nand earn cashback",
                          color: pDisable,
                          size: 15,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          pVerticalSpace(height: 40.0),
                          Expanded(
                            child: new Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CustomButton(
                                        height: 30.0,
                                        isEnabled: true,
                                        radius: 40.0,
                                        tvColor: Colors.red,
                                        tvSize: 16,
                                        width: 90,
                                        color: Colors.white,
                                        btnTitle: "Add Now",
                                        onPress: () {
                                          Get.toNamed(AppRoute.nordiGen);
                                        }),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                      offer,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
