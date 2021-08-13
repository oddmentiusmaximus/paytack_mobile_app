import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionChecker = PermissionHandle();

class PermissionHandle {
  Future<bool> checkPermissionStorage(
      {BuildContext? context, Permission? permissionGroup}) async {
    final status = await permissionGroup!.request();
    if (status.isDenied) {
      Get.defaultDialog(
        title: "Allow Permission",
        middleText: "Go to Settings and provide Storage Permission!",
        backgroundColor: Colors.white,
        titleStyle: commonTextStyle(),
        middleTextStyle: commonTextStyle(),
      );
      return false;
    } else if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
