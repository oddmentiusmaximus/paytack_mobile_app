import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/network/api_helpser.dart';
import 'package:paytack/common_function/network/network_class.dart';

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
        success: (success) {
          print(success.toString());
        },
        error: (error) {});
  }
}
