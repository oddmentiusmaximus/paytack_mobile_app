import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:permission_handler/permission_handler.dart';

final permissionChecker = PermissionHandle();

class PermissionHandle {
  Future<bool> checkPermissionStorage(
      {BuildContext? context, PermissionGroup? permissionGroup}) async {
    await PermissionHandler()
        .requestPermissions([permissionGroup ?? PermissionGroup.storage]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(permissionGroup ?? PermissionGroup.storage);
    if (permission == PermissionStatus.neverAskAgain) {
      Get.defaultDialog(
        title: "Allow Permission",
        middleText: "Go to Settings and provide Storage Permission!",
        backgroundColor: Colors.white,
        titleStyle: commonTextStyle(),
        middleTextStyle: commonTextStyle(),
      );
      return false;
    } else if (permission == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
