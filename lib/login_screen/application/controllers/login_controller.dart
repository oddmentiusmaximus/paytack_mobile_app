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

  @override
  void onInit() {
    super.onInit();
    loginEmailController = TextEditingController();
    loginPinController = TextEditingController();
    forgotPinEmailController = TextEditingController();
    setPinController = TextEditingController();
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
        baseUrl: ApiHelpers.baseUrl + ApiHelpers.forgotPassword,
        parameter: params,
        success: (success) async {
          Get.back();

          showCommonWithWidget(
              barrierDismissible: false,
              context: context,
              title: "Enter Pin",
              message: "Enter the PIN sent on your email",
              widget: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TInput(
                          controller: setPinController,
                          hintText: "Pin",
                          maxLines: 1,
                          type: 'B1',
                          isEdit: false,
                          isError: false,
                          isInput: true,
                          keyboardType: TextInputType.name,
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
                                setPinController!.text.length == 4) {
                            } else {
                              showToast(msg: "Enter Valid Pin");
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

  void toggleObscureText() {
    isPin.value = !isPin.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    loginEmailController!.dispose();
    loginPinController!.dispose();
    forgotPinEmailController!.dispose();
    super.dispose();
  }
}
