import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/common_function/secure_storage.dart';
import 'package:paytack/common_function/utils/loading_class.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/home/application/controllers/dashboard_controller.dart';

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
  TextEditingController? newPinController;
  TextEditingController? confirmPinController;

  ///ChangePhoneNo
  String countryCode = '';
  TextEditingController? optionalDetailsMobileNo;
  TextEditingController? editEmail;
  RxBool isEmailError = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getReferralCode();
    optionalDetailsMobileNo = TextEditingController();
    popUpPinController = TextEditingController();
    editEmail = TextEditingController();
    newPinController = TextEditingController();
    confirmPinController = TextEditingController();
  }

  Future<void> getReferralCode() async {
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.getReferralCode,
        success: (success) async {
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
    Loading.show(context: context);
    // Map<String, dynamic> params = {
    //   "phonenumber": optionalDetailsMobileNo!.text.trim(),
    // };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.updatePhone +
            "?phonenumber=${optionalDetailsMobileNo!.text.trim()}",
        // parameter: params,
        success: (success) async {
          Navigator.of(context).pop();
          Get.back();
          update();
        },
        error: (error) {
          Get.back();
          update();
          print(error);
        });
  }

  Future updateEmail(BuildContext context) async {
    Loading.show(context: context);
    // Map<String, dynamic> params = {
    //   "email": editEmail!.text.trim(),
    // };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.updateEmail +
            '?email=${editEmail!.text.trim()}',
        success: (success) async {
          Navigator.of(context).pop();
          await Get.find<DashBoardController>().getUserData();
          editEmail!.clear();
          Get.back();
          update();
        },
        error: (error) {
          update();
          print(error);
        });
    // Get.back();
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

  Future<void> submitFeedback(String val, BuildContext context) async {
    Loading.show(context: context);

    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.help + "?description=$val",
        //parameter: params,
        success: (success) {
          String message = 'Thank you for your Feedback';

          print(success.toString());
          if (success.toString().isNotEmpty) {
            showCommonWithWidget(
              barrierDismissible: false,
              context: context,
              title: "",
              image: success_tick,
              message: message,
              imageTrue: true,
              widget: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomButton(
                    color: pPrimaryColor,
                    isEnabled: true,
                    tvSize: 16.0,
                    width: 100,
                    tvColor: Colors.white,
                    height: 45.0,
                    radius: 12.0,
                    btnTitle: "Ok",
                    onPress: () async {
                      Get.back();
                      Get.back();
                    }),
              ),
            );
          }
          update();
        },
        error: (error) {
          showCommonWithWidget(
            barrierDismissible: false,
            context: context,
            title: "",
            image: success_tick,
            message: "Error while sending feedback",
            imageTrue: true,
            widget: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  color: pPrimaryColor,
                  isEnabled: true,
                  tvSize: 16.0,
                  width: 100,
                  tvColor: Colors.white,
                  height: 45.0,
                  radius: 12.0,
                  btnTitle: "Ok",
                  onPress: () {
                    Get.back();
                    Get.back();
                  }),
            ),
          );
        });
  }

  Future<void> setNewPin(BuildContext context) async {
    Loading.show(context: context);
    String? token = await CommonStorage.readSecureStorageData("access_token");

    Map<String, dynamic> params = {
      "email": Get.find<DashBoardController>().userEmail,
      "password": newPinController!.text,
      "confirmPassword": confirmPinController!.text,
      "token": token,
    };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.resetPassword,
        parameter: params,
        success: (success) async {
          await CommonStorage.writeSecureStorageData(
              login_pin_key, confirmPinController!.text.trim());
          Get.back();
          showCommonWithWidget(
            barrierDismissible: false,
            context: context,
            title: "",
            image: success_tick,
            message: 'Pin changed successfully!!',
            imageTrue: true,
            widget: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  color: pPrimaryColor,
                  isEnabled: true,
                  tvSize: 16.0,
                  width: 100,
                  tvColor: Colors.white,
                  height: 45.0,
                  radius: 12.0,
                  btnTitle: "Ok",
                  onPress: () {
                    Get.back();
                  }),
            ),
          );
        },
        error: (error) {
          Get.back();
          String errorMsg = 'Server Error';
          showCommonWithWidget(
            barrierDismissible: false,
            context: context,
            title: "",
            image: error_icon,
            message: errorMsg,
            imageTrue: true,
            widget: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                  color: pPrimaryColor,
                  isEnabled: true,
                  tvSize: 16.0,
                  width: 100,
                  tvColor: Colors.white,
                  height: 45.0,
                  radius: 12.0,
                  btnTitle: "Ok",
                  onPress: () {
                    Get.back();
                  }),
            ),
          );
        });
  }
}
