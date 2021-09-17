import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:paytack/common_function/widget/textinput.dart';
import 'package:paytack/routes/app_screens.dart';

class LoginController extends GetxController {
  Map<String, dynamic>? loginSuccessResponse;

  LoginController(this._networkRepository);

  RxBool isEmailError = false.obs;
  RxBool isEmailForgotError = false.obs;
  RxBool isPin = true.obs;
  final NetworkProvider _networkRepository;
  TextEditingController? loginEmailController;
  TextEditingController? loginPinController;
  TextEditingController? forgotPinEmailController;
  TextEditingController? setPinController;
  TextEditingController? setNewPinController;


  String token='';
  ///Set Pin Screen
  TextEditingController? confirmPinController;
  TextEditingController? createPinController;
  RxBool isCreatePin = true.obs;
  RxBool isConfirmPin = true.obs;

  toggleObscure(bool isCreate, bool isConfirm) {
    if (isCreate) {
      isCreatePin.value = !isCreatePin.value;
    } else if (isConfirm) {
      isConfirmPin.value = !isConfirmPin.value;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loginEmailController = TextEditingController();
    loginPinController = TextEditingController();
    forgotPinEmailController = TextEditingController();
    setPinController = TextEditingController();
    setNewPinController = TextEditingController();
    confirmPinController = TextEditingController();
    createPinController = TextEditingController();
  }

  Future<void> getLogin(BuildContext context) async {
    Loading.show(context: context);
    Map<String, dynamic> params = {
      "email": loginEmailController!.text.trim(),
      "password": loginPinController!.text.trim()
    };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.login,
        parameter: params,
        success: (success) async {
          Get.back();

          await CommonStorage.writeSecureStorageData(
              secure_access_key, success['token']);
          await CommonStorage.writeSecureStorageData(
              login_pin_key, loginPinController!.text.trim());
          Get.offAllNamed(AppRoute.homeLanding);
        },
        error: (error) {
          Get.back();
          String errorMsg = 'Please Enter Login Valid Details';
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

  Future<void> resetPin(BuildContext context) async {
    Loading.show(context: context);
    Map<String, dynamic> params = {
      "email": forgotPinEmailController!.text.trim(),
    };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.forgotPassword +
            "?email=${forgotPinEmailController!.text.trim()}",
        //parameter: params,
        success: (success) async {
          Get.back();
          Get.back();
          showCommonWithWidget(
              barrierDismissible: false,
              context: context,
              title: "Verify OTP",
              message: "Enter the OTP sent on your email",
              widget: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TInput(
                          controller: setPinController,
                          hintText: "OTP",
                          maxLines: 1,
                          type: 'B1',
                          isEdit: false,
                          isError: false,
                          isInput: true,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                          ],
                          keyboardType: TextInputType.number,
                          onChange: (val) {}),
                      pVerticalSpace(height: 30.0),
                      CustomButton(
                          color: pPrimaryColor,
                          isEnabled: true,
                          tvSize: 16.0,
                          tvColor: Colors.white,
                          height: 45.0,
                          radius: 12.0,
                          width: 120.0,
                          btnTitle: "Send",
                          onPress: () {
                            if (setPinController!.text.isNotEmpty &&
                                setPinController!.text.length == 6) {
                              verifyOtp(context, setPinController!.text);
                            } else {
                              showToast(msg: "Enter Valid OTP");
                            }
                          }),
                    ],
                  )));
        },
        error: (error) {
          Get.back();
          String errorMsg = 'Please Enter Valid Email';
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

  Future<void> verifyOtp(BuildContext context, String otp) async {
    Loading.show(context: context);
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.verifyOtp +
            "?email=${forgotPinEmailController!.text.trim()}&OTP=$otp",
        //parameter: params,
        success: (success) async {
          Get.back();
           token = success['token'];
          Get.toNamed(AppRoute.setForgotPassword);
        },
        error: (error) {
          Get.back();
          String errorMsg = 'Please Enter Valid OTP';
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

  Future<void> setNewPin(BuildContext context) async {
    Loading.show(context: context);
    Map<String, dynamic> params = {
      "email": forgotPinEmailController!.text,
      "password":createPinController!.text,
      "confirmPassword": confirmPinController!.text,
      "token": token,
    };
    _networkRepository.postMethod(
        baseUrl: ApiHelpers.baseUrl +
            ApiHelpers.resetPassword,
        parameter: params,
        success: (success) async {
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
                    Get.offNamed(AppRoute.login);
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

  void toggleObscureText() {
    isPin.value = !isPin.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginEmailController!.dispose();
    loginPinController!.dispose();
    forgotPinEmailController!.dispose();
    setNewPinController!.dispose();
    createPinController!.dispose();
    confirmPinController!.dispose();
    super.dispose();
  }
}
