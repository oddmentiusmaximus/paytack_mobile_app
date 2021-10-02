import 'package:get/get.dart';
import 'package:paytack/common_function/network/dio_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';
import 'package:paytack/login_screen/application/controllers/login_controller.dart';
import 'package:paytack/my_profile/application/profile_controller.dart';
import 'package:paytack/sign_up/application/controllers/signup_controller.dart';

class DashBoardBinding implements Bindings {
  @override
  void dependencies() {
    final apiBaseHelper = DioHelper();
    Get.lazyPut(() => NetworkProvider(apiBaseHelper));
    Get.put<DashBoardController>(DashBoardController(Get.find()));
    Get.put<ProfileController>(ProfileController(Get.find()));

  }
}
