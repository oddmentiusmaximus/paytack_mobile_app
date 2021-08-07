import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/intro_screen/presentation/intro_screen_first.dart';
import 'package:paytack/intro_screen/presentation/slide_dots.dart';
import 'package:paytack/intro_screen/presentation/slide_model.dart';
import 'package:paytack/routes/app_screens.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splash_bg),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                // alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: slideList.length,
                    itemBuilder: (ctx, i) {
                      return IntroFirst(index: i);
                    },
                  ),
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
                            for (int i = 0; i < slideList.length; i++)
                              if (i == _currentPage)
                                SlideDots(true)
                              else
                                SlideDots(false)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            pVerticalSpace(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: buttonForBottom(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonForBottom() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 25),
            child: CustomButton(
                height: 48.0,
                isEnabled: true,
                radius: 12.0,
                tvSize: 16,
                btnTitle: "Sign Up",
                onPress: ()  {
                   Get.offNamed(AppRoute.signUp);
                })),
        pVerticalSpace(height: 5.0),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoute.login);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TView(
              title: "I already have an account",
              color: pProgress,
              size: 16,
            ),
          ),
        ),
        pVerticalSpace(height: 18.0)
      ],
    );
  }

  void buttonTap() {}
}
