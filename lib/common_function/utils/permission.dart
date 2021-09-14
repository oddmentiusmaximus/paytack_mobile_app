import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/common_function/widget/mytext.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionChecker = PermissionHandle();

class PermissionHandle {
  Future<bool> checkPermissionStorage(
      {BuildContext? context, Permission? permissionGroup}) async {
    final status = await permissionGroup!.request();
    if (status.isDenied) {
      showCommonWithWidget(
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
                  onPress: () {
                    permission();
                  }),
              pVerticalSpace(height: 15.0),
              InkWell(
                onTap: () {
                  Get.find<DashBoardController>().loader = true;
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
        ),
      );
      return false;
    } else if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
  Future<void> permission() async {
    final Permission locationPermission = Permission.location;
    bool locationStatus = false;
    bool isPermanantlyDenied = await locationPermission.isDenied;
    if (isPermanantlyDenied) {
      print("denied");
      await openAppSettings();
    } else {
      var locationStat = await locationPermission.request();
      locationStatus = locationStat.isGranted;
      print(locationStatus);
    }
  }

}

