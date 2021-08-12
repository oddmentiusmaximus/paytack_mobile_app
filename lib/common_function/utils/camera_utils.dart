import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/utils/permission.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';

Future<void> _showChoiceDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext popupContext) {
        return AlertDialog(
          title: Text(
            'Select Profile Photo From:',
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
                        .checkPermissionStorage(context: context);
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
                        .checkPermissionStorage(context: context);
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
  } else {
    picture = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  }

  Navigator.pop(buildContext);
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
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.white,
      textColor: textColor ?? pPrimaryColor);
}
