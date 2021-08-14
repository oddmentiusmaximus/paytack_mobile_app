import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/permission.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> showChoiceDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext popupContext) {
        return AlertDialog(
          title: Text(
            'Upload Bill From:',
            style: commonTextStyle(),
          ),
          content: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// To upload from camera
                GestureDetector(
                  onTap: () async {
                    bool permission = await PermissionHandle()
                        .checkPermissionStorage(
                            context: context,
                            permissionGroup: Permission.storage);
                    if (permission == true) {
                       openCamera(popupContext, true);
                    } else {
                      ///show messge
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              color: Color(0xffd7d0c8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: pDisable,
                          )),
                      SizedBox(height: 10),
                      Text(
                        'Camera',
                        style: commonTextStyle(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),

                /// To upload from gallery
                GestureDetector(
                  onTap: () async {
                    bool permission = await PermissionHandle()
                        .checkPermissionStorage(
                            context: context,
                            permissionGroup: Permission.storage);
                    if (permission == true) {
                      openCamera(popupContext, false);
                    } else {
                      ///show messge
                    }
                  },
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Color(0xffd7d0c8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Icon(
                          Icons.photo_album,
                          color: pDisable,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Gallery',
                        style: commonTextStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

openCamera(BuildContext buildContext, bool type) async {
  var picture;
  if (type) {
    picture = await ImagePicker.platform.pickImage(source: ImageSource.camera);
   // onchange(picture);
  } else {
    picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  //  onchange(picture);
  }
  Navigator.pop(buildContext);
  Get.find<DashBoardController>().uploadBill(picture,buildContext);
  //Loading.show(context: buildContext);
}

showToast(
    {required String msg,
    Toast? toastLength,
    double? fontSize,
    Color? backgroundColor,
    ToastGravity? gravity,
    Color? textColor}) {
  gravity = ToastGravity.CENTER;
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      fontSize: fontSize,
      gravity: gravity,
      backgroundColor: backgroundColor ?? Colors.white,
      textColor: textColor ?? pPrimaryColor);
}
