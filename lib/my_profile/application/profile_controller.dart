import 'package:get/get.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';

class ProfileController extends GetxController {
  ProfileController(this._networkRepository);

  final NetworkProvider _networkRepository;
  String? referralCode = '';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getReferralCode();
  }

  Future<void> getReferralCode() async {
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.getReferralCode,
        success: (success) {
          print(success.toString());
          if (success.toString().isNotEmpty) {
            referralCode = success.toString();
          }
          update();
        },
        error: (error) {
          print(error);
        });
  }
}
