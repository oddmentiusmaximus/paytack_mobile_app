import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';

class ProfileController extends GetxController {
  ProfileController(this._networkRepository);

  final NetworkProvider _networkRepository;
  String? referralCode = '';

  ///myprofile
  RxBool popUpVerifyPin = false.obs;
  TextEditingController? popUpPinController;

  ///ChangePinPage
  RxBool showPin = false.obs;
  RxBool showConfirmPin = false.obs;

  ///ChangePhoneNo
  String countryCode = '';
  TextEditingController? optionalDetailsMobileNo;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getReferralCode();
    optionalDetailsMobileNo = TextEditingController();
    popUpPinController = TextEditingController();
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

  void updatePhone(BuildContext context) {
    Map<String, dynamic> params = {
      "phonenumber": optionalDetailsMobileNo!.text.trim(),
    };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.updatePhone,
        parameter: params,
        success: (success) async {
          Navigator.of(context).pop();
          update();
        },
        error: (error) {
          update();
          print(error);
        });
  }

  toggleObscureText(bool isCreate, bool isConfirm) {
    if (isCreate) {
      showPin.value = !showPin.value;
    } else if (isConfirm) {
      showConfirmPin.value = !showConfirmPin.value;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    popUpPinController!.dispose();
    super.onClose();
  }
}
