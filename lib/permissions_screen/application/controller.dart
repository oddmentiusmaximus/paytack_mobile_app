import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';

class PermissionsController extends GetxController {
  bool isSignUp = false;

  ///Permission Screen
  bool emailPermission = true;
  bool pnPermission = true;
  bool smsPermission = true;

  togglePermission(bool isEmail, bool isPN, bool isSMS) {
    if (isEmail) {
      emailPermission = !emailPermission;
    } else if (isPN) {
      pnPermission = !pnPermission;
    } else if (isSMS) {
      smsPermission = !smsPermission;
    } else {
      showToast(msg: 'Permission Required');
    }
    update();
  }
}
