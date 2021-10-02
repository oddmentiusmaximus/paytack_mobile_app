import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paytack/common_function/assets_file.dart';
import 'package:paytack/common_function/common_dialog.dart';
import 'package:paytack/common_function/constants.dart';
import 'package:paytack/common_function/network/api_helper.dart';
import 'package:paytack/common_function/network/network_class.dart';
import 'package:paytack/common_function/secure_storage.dart';
import 'package:paytack/common_function/utils/camera_utils.dart';
import 'package:paytack/common_function/utils/loading_class.dart';
import 'package:paytack/common_function/widget/button.dart';
import 'package:paytack/routes/app_screens.dart';

class SignupController extends GetxController {
  String? errorMsg;
  Map<String, dynamic>? loginSuccessResponse;

  SignupController(this._networkRepository);

  final NetworkProvider _networkRepository;

  ///SignUp Screen
  TextEditingController? signUpName;

  TextEditingController? signUpEmail;

  TextEditingController? signUpReferralCode;

  RxBool isNameError = false.obs;
  RxBool isEmailError = false.obs;
  FocusNode firstPinCode = FocusNode();
  FocusNode secondPinCode = FocusNode();
  @override
  void onInit() {
    super.onInit();
    signUpName = TextEditingController();
    signUpEmail = TextEditingController();
    signUpReferralCode = TextEditingController();
    createPinController = TextEditingController();
    confirmPinController = TextEditingController();
    optionalDetailsMobileNo = TextEditingController();
    optionalDetailsCity = TextEditingController();
  }

  Future<void> getSignIn(BuildContext context) async {
    Loading.show(context: context);
    Map<String, dynamic> params = {
      "email": signUpEmail!.text.trim(),
      "password": createPinController!.text.trim(),
      "confirmPassword": confirmPinController!.text.trim(),
      "clientName": signUpName!.text.trim(),
      "countryCode":optionalDetailsMobileNo!.text.isEmpty?' ': countryCode.trim(),
      "phoneNumber": optionalDetailsMobileNo!.text.isEmpty
          ? ' '
          : optionalDetailsMobileNo!.text.trim(),
      "gender": " ",
      "dateOfBirth":
          birthdayDate.trim() == 'Birthday' ? ' ' : birthdayDate.trim(),
      "anniversaryDate": anniversaryDate.trim() == 'Anniversary'
          ? ' '
          : anniversaryDate.trim(),
      "referralCode": signUpReferralCode!.text.isEmpty
          ? ' '
          : signUpReferralCode!.text.trim()
    };
    print(params);
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.register,
        parameter: params,
        success: (success) async {
          Get.back();
          await CommonStorage.writeSecureStorageData(
              secure_access_key, success['token']);
          await CommonStorage.writeSecureStorageData(
              login_pin_key, confirmPinController!.text.trim());
          Get.offAllNamed(AppRoute.homeLanding);
          print(success.toString());
        },
        error: (error) {
          Get.back();
          showCommonWithWidget(
            barrierDismissible: false,
            context: context,
            title: "",
            image: error_icon,
            message: error.toString(),
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

  Future<void> checkEmail(BuildContext context) async {
    Loading.show(context: context);
    _networkRepository.getMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.emailExist +
            "?email=${signUpEmail!.text.trim()}",
        success: (success) {
          Get.back();
          if (success.toString() == 'true') {
            showCommonWithWidget(
              barrierDismissible: false,
              context: context,
              title: "",
              image: error_icon,
              message:
                  "Entered email already registered with us.\n Please enter another email.",
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
          } else {
            Get.toNamed(AppRoute.addCard);
          }
          print(success.toString());
        },
        error: (error) {
          Get.back();
        });
  }

  ///optional Details Screen
  String birthdayDate = 'Birthday';
  String anniversaryDate = 'Anniversary';
  String countryCode = '';
  TextEditingController? optionalDetailsMobileNo;
  TextEditingController? optionalDetailsCity;

  updateDate(bool birthdateUpdate, String _selectedDate) {
    if (birthdateUpdate == true) {
      birthdayDate = _selectedDate;
    } else {
      anniversaryDate = _selectedDate;
    }
    update();
  }


  ///Set Pin Screen
  TextEditingController? confirmPinController;
  TextEditingController? createPinController;
  RxBool isCreatePin = true.obs;
  RxBool isConfirmPin = true.obs;

  toggleObscureText(bool isCreate, bool isConfirm) {
    if (isCreate) {
      isCreatePin.value = !isCreatePin.value;
    } else if (isConfirm) {
      isConfirmPin.value = !isConfirmPin.value;
    }
  }

  @override
  void dispose() {
    // TODO: implement onClose
    signUpName!.dispose();
    signUpEmail!.dispose();
    signUpReferralCode!.dispose();
    createPinController!.dispose();
    confirmPinController!.dispose();
    optionalDetailsMobileNo!.dispose();
    optionalDetailsCity!.dispose();
    super.dispose();
  }
}
