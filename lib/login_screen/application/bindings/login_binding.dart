import 'package:get/get.dart';
import 'package:paytack/common_function/network/dio_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/login_screen/application/controllers/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    final apiBaseHelper = DioHelper();
    Get.lazyPut(() => NetworkProvider(apiBaseHelper));
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }
}
