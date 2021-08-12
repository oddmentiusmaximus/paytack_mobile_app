import 'package:get/get.dart';
import 'package:paytack/common_function/network/dio_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/login_screen/application/controllers/login_controller.dart';
import 'package:paytack/sign_up/application/controllers/signup_controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    final apiBaseHelper = DioHelper();
    Get.lazyPut(() => NetworkProvider(apiBaseHelper));
    Get.lazyPut<SignupController>(() => SignupController(Get.find()));

  }
}
