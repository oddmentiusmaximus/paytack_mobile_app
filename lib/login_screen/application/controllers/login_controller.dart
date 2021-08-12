import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/common_function/secure_storage.dart';
import 'package:paytack/routes/app_screens.dart';

class LoginController extends GetxController {
  String? errorMsg;
  Map<String, dynamic>? loginSuccessResponse;

  LoginController(this._networkRepository);

  final NetworkProvider _networkRepository;

  Future<void> getLogin() async {
    Map<String, dynamic> params = {
      "email": "testclient@paytack.com",
      "password": "1234"
    };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.login,
        parameter: params,
        success: (success) async {
          await CommonStorage.writeSecureStorageData(
              "access_token", success['token']);
          Get.offAllNamed(AppRoute.homeLanding);
        },
        error: (error) {});
  }
}
