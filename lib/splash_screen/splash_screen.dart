import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/secure_storage.dart';
import 'package:paytack/routes/app_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    String loginAccess =
        await CommonStorage.readSecureStorageData(secure_access_key) ?? '';
    // loginAccess.isEmpty
    //     ? Get.offNamed(AppRoute.discover_page)
    Get.offNamed(AppRoute.homeLanding);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              splash_logo,
              fit: BoxFit.contain,
              height: 250,
              width: 200,
            ),
          ),
        ],
      ),
    ));
  }
}
